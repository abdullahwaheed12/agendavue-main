import 'dart:developer';

import 'package:agendavue/data/apiClient/student_data_configration.dart';
import 'package:agendavue/data/models/class_schedule.dart';
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';

import 'studentdata.dart';
import 'package:xml/xml.dart';
import 'studentgradedata.dart';
import 'zip_code_result.dart';

// void debugPrint(dynamic d) {
//   print(d);
// }

class StudentVueClient {
  final domain;
  late String reqURL;

  final bool mock;
  final String username, password;
  final bool studentAccount;

  StudentVueClient(this.username, this.password, this.domain,
      {this.studentAccount = true, this.mock = false}) {
    // reqURL = domain + '/Service/PXPCommunication.asmx?WSDL';
    reqURL =
        'https://md-mcps-psv.edupoint.com/Service/PXPCommunication.asmx?WSDL';
    // reqURL = 'https://' + domain + '/Service/PXPCommunication.asmx?WSDL';
  }

  final Dio _dio = Dio(BaseOptions(validateStatus: (_) => true));

  Future<StudentGradeData> loadGradebook(
      {Function(double)? callback, String? termIndex}) async {
    String? resData;
    var requestData;
    if (true) {
      if (termIndex != null) {
        log('aaaaaaaaaaaa' + termIndex);
//password : batDANY1997\$\$
//username : 211075
        requestData = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
        <ProcessWebServiceRequest xmlns="http://edupoint.com/webservices/">
            <userID>$kuserName</userID>
            <password>$kpassword</password>
            <skipLoginLog>1</skipLoginLog>
            <parent>0</parent>
            <webServiceHandleName>PXPWebServices</webServiceHandleName>
            <methodName>Gradebook</methodName>
            <paramStr>&lt;Parms&gt;&lt;ReportPeriod&gt;$termIndex&lt;/ReportPeriod&gt;&lt;/Parms&gt;</paramStr>
        </ProcessWebServiceRequest>
    </soap:Body>
</soap:Envelope>
    
    ''';
      } else {
        requestData = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
        <ProcessWebServiceRequest xmlns="http://edupoint.com/webservices/">
            <userID>$kuserName</userID>
            <password>$kpassword</password>
            <skipLoginLog>1</skipLoginLog>
            <parent>0</parent>
            <webServiceHandleName>PXPWebServices</webServiceHandleName>
            <methodName>Gradebook</methodName>
            <paramStr>&lt;Parms&gt;&lt;ChildIntID&gt;00&lt;/ChildIntID&gt;&lt;/Parms&gt;</paramStr>
        </ProcessWebServiceRequest>
    </soap:Body>
</soap:Envelope>
    
    ''';
      }

      var headers = {'Content-Type': 'text/xml', 'Accept': '*/*'};

      var res = await _dio.post(reqURL,
          data: requestData,
          options: Options(headers: headers), onSendProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5);
        }
      }, onReceiveProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5 + 0.5);
        }
      });

      resData = res.data;
    }

    // log('--->>> load grade book $resData');
    XmlDocument.parse(resData!);
    final document = XmlDocument.parse(HtmlUnescape().convert(resData));
    // await Future.delayed(const Duration(milliseconds: 1500));
//    final document = XmlDocument.parse(testData);
    if (resData.contains('Invalid user id or password')) {
      return StudentGradeData()..error = 'Invalid user id or password';
    }
    if (resData.contains('The user name or password is incorrect')) {
      return StudentGradeData()
        ..error = 'The user name or password is incorrect';
    }

    var svData = StudentGradeData();
    //current MP extract
    var currentMP = document
        .findAllElements('ReportingPeriod')
        .first
        .getAttribute('GradePeriod');
    // reporting periods extract
    var reportingPeriod = document.findAllElements('ReportingPeriods');

    List<ReportingPeriods> reportingPeriodList = [];
    for (var element in reportingPeriod.toList()[0].childElements) {
      reportingPeriodList.add(ReportingPeriods(
          name: element.getAttribute('GradePeriod') ?? 'empty',
          value: element.getAttribute('Index') ?? 'empty'));
    }
    svData.currentMp = currentMP;
    svData.reportingPeriods = reportingPeriodList;
    //courses extract
    var courses = document.findAllElements('Courses').first;

    var classes = <SchoolClass>[];
    for (var i = 0; i < courses.children.length; i++) {
      var current = courses.children[i];
      if (current.getAttribute('Title') == null) continue;
      var _class = SchoolClass();

      _class.className = current
          .getAttribute('Title')!
          .substring(0, current.getAttribute('Title')!.indexOf('('));

      _class.period = int.tryParse(current.getAttribute('Period') ?? '0') ?? -1;
      _class.roomNumber = current.getAttribute('Room') ?? 'N/A';
      _class.classTeacher = current.getAttribute('Staff') ?? 'N/A';
      _class.classTeacherEmail = current.getAttribute('StaffEMail') ?? 'N/A';

      var mark = current.findAllElements('Mark').first;
      _class.pctGrade = mark.getAttribute('CalculatedScoreRaw');
      _class.letterGrade = mark.getAttribute('CalculatedScoreString');
      current = current.findAllElements('GradeCalculationSummary').first;
      // if (current == null) {
      //   classes.add(_class);
      //   continue;
      // }

      _class.assignmentCategories = <AssignmentCategory>[];
      for (var i = 0; i < current.children.length; i++) {
        if (current.children[i].getAttribute('Type') == 'TOTAL') {
          _class.earnedPoints =
              double.tryParse(current.children[i].getAttribute('Points') ?? '');
          _class.earnedPoints = double.tryParse(
              current.children[i].getAttribute('PointsPossible') ?? '');
          _class.pctGrade ??= current.children[i]
              .getAttribute('WeightedPct'); // replace only if it's already null
        } // else {
        var category = AssignmentCategory();
        category.name = current.children[i].getAttribute('Type');
        category.weight = double.tryParse(
                (current.children[i].getAttribute('Weight') ?? '')
                    .replaceAll('%', '')) ??
            0.0;

        category.earnedPoints =
            double.tryParse(current.children[i].getAttribute('Points') ?? '') ??
                0.0;

        category.possiblePoints = double.tryParse(
                current.children[i].getAttribute('PointsPossible') ?? '') ??
            0.0;
        _class.assignmentCategories!.add(category);
      }

      current = current.parent!.findAllElements('Assignments').first;
      // if (current == null) {
      //   classes.add(_class);
      //   continue;
      // }

      _class.assignments = <Assignment>[];
      for (var i = 0; i < current.children.length; i++) {
        var ass = Assignment();
        ass.assignmentName =
            current.children[i].getAttribute('Measure') ?? 'Assignment';
        ass.notes = current.children[i].getAttribute('Notes') ?? '';
        ass.category =
            current.children[i].getAttribute('Type') ?? 'No Category';
        ass.date = current.children[i].getAttribute('DueDate') ?? '';
        ass.earnedPoints =
            current.children[i].getAttribute('Score') == 'Not Graded'
                ? -1
                : double.tryParse(
                        (current.children[i].getAttribute('Points') ?? 'N/A')
                            .replaceAll(' ', '')
                            .split('/')[0]) ??
                    -1;
        if (current.children[i].getAttribute('Score') == 'Not Graded') {
          ass.possiblePoints = double.tryParse(
              (current.children[i].getAttribute('Points') ?? '')
                  .replaceAll(' Points Possible', ''));
        } else {
          if (double.tryParse(
                  current.children[i].getAttribute('Score') ?? 'N/A') ==
              null) {
            var pointsStr =
                (current.children[i].getAttribute('Points') ?? 'N/A')
                    .replaceAll(' ', '')
                    .split('/');
            if (pointsStr.length < 2) {
              ass.possiblePoints = -1;
            } else {
              var pp = double.tryParse(pointsStr[1]);
              ass.possiblePoints = pp ?? -1;
            }
          } else {
            ass.possiblePoints = double.tryParse(
                current.children[i].getAttribute('Score') ?? 'N/A');
          }
        }
        _class.assignments!.add(ass);
      }

      classes.add(_class);
    }
    svData.classes = classes;

    return svData;
  }

  Future<StudentData> loadStudentData({Function(double)? callback}) async {
    String? resData;
    if (true) {
      var requestData = '''
<?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
          <ProcessWebServiceRequest xmlns="http://edupoint.com/webservices/">
              <userID>$kuserName</userID>
            <password>$kpassword</password>
            <skipLoginLog>1</skipLoginLog>
            <parent>0</parent>
              <webServiceHandleName>PXPWebServices</webServiceHandleName>
              <methodName>StudentInfo</methodName>
              <paramStr>&lt;Parms&gt;&lt;ChildIntID&gt;0&lt;/ChildIntID&gt;&lt;/Parms&gt;</paramStr>
          </ProcessWebServiceRequest>
      </soap:Body>
  </soap:Envelope>''';

      var headers = {'Content-Type': 'text/xml'};

      var res = await _dio.post(reqURL,
          data: requestData,
          options: Options(headers: headers), onSendProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5);
        }
      }, onReceiveProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5 + 0.5);
        }
      });
      resData = res.data;
    }
    //  else {
    //   resData = MockResponses.StudentInfoResponse;
    // }
    final document = XmlDocument.parse(HtmlUnescape().convert(resData!));

    // the StudentInfo element is inside four other dumb elements
    final el = document.root.firstElementChild!.firstElementChild!
        .firstElementChild!.firstElementChild!.firstElementChild!;

    return StudentData(
      lockerInfo: el.getElement('LockerInfoRecords')?.innerText,
      formattedName: el.getElement('FormattedName')?.innerText,
      permId: el.getElement('PermID')?.innerText,
      gender: el.getElement('Gender')?.innerText,
      grade: el.getElement('Grade')?.innerText,
      address: el.getElement('Address')?.innerText,
      lastNameGoesBy: el.getElement('LastNameGoesBy')?.innerText,
      nickname: el.getElement('NickName')?.innerText,
      birthdate: el.getElement('BirthDate')?.innerText,
      email: el.getElement('EMail')?.innerText,
      phone: el.getElement('Phone')?.innerText,
      homeLanguage: el.getElement('HomeLanguage')?.innerText,
      currentSchool: el.getElement('CurrentSchool')?.innerText,
      homeroomTeacher: el.getElement('HomeRoomTch')?.innerText,
      homeroomTeacherEmail: el.getElement('HomeRoomTchEMail')?.innerText,
      homeroom: el.getElement('HomeRoom')?.innerText,
      counselorName: el.getElement('CounselorName')?.innerText,
      photo: el.getElement('Photo')?.innerText,
      physicianName: el.getElement('Physician')?.getAttribute('Name'),
      physicianPhone: el.getElement('Physician')?.getAttribute('Phone'),
      dentistName: el.getElement('Dentist')?.getAttribute('Name'),
      dentistPhone: el.getElement('Dentist')?.getAttribute('Phone'),
    );
  }

  Future<List<ClassInfo>> loadStudentClassList(
      {Function(double)? callback}) async {
    String? resData;
    if (true) {
      var requestData = '''
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
<soap:Body><ProcessWebServiceRequest xmlns="http://edupoint.com/webservices/">
  <userID>$kuserName</userID>
  <password>$kpassword</password>
<skipLoginLog>1</skipLoginLog><parent>0</parent><webServiceHandleName>PXPWebServices</webServiceHandleName>
<methodName>StudentClassList</methodName><paramStr>&lt;Parms&gt;&lt;childIntID&gt;0&lt;/childIntID&gt; &lt;TermIndex&gt;1&lt;/TermIndex&gt; &lt;/Parms&gt;</paramStr></ProcessWebServiceRequest></soap:Body></soap:Envelope>
  ''';

      var headers = {'Content-Type': 'text/xml'};

      var res = await _dio.post(reqURL,
          data: requestData,
          options: Options(headers: headers), onSendProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5);
        }
      }, onReceiveProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5 + 0.5);
        }
      });
      resData = res.data;
    }
    // resData = MockResponses.ClassSchedule;
    // log('resData $resData');
    final document = XmlDocument.parse(HtmlUnescape().convert(resData!));
    var a = document.root.firstElementChild!.firstElementChild!
        .firstElementChild!.firstElementChild!.firstElementChild!;

    var b = a
        .getElement('TodayScheduleInfoData')!
        .childElements
        .first
        .children[1]
        .children[1]
        .children;
    var listOfClasses = <ClassInfo>[];
    for (var element in b) {
      listOfClasses.add(ClassInfo(
        period: element.getAttribute('Period'),
        className: element.getAttribute('ClassName'),
        classUrl: element.getAttribute('ClassURL'),
        startTime: element.getAttribute('StartTime'),
        endTime: element.getAttribute('EndTime'),
        teacherName: element.getAttribute('EndTime'),
        teacherUrl: element.getAttribute('TeacherURL'),
        emailSubject: element.getAttribute('EmailSubject'),
        roomName: element.getAttribute('RoomName'),
        startDate: element.getAttribute('StartDate'),
        endDate: element.getAttribute('EndDate'),
      ));
    }

    return listOfClasses;
  }

  static Future<List<ZipCodeResult>> loadDistrictsFromZip(String zip,
      {Function(double)? callback, bool mock = true}) async {
    String? resData;

    if (true) {
      var requestData = '''<?xml version="1.0" encoding="utf-8"?>
<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
    <v:Header />
    <v:Body>
        <ProcessWebServiceRequestMultiWeb xmlns="http://edupoint.com/webservices/" id="o0" c:root="1">
            <userID i:type="d:string">EdupointDistrictInfo</userID>
            <password i:type="d:string">Edup01nt</password>
            <skipLoginLog i:type="d:string">false</skipLoginLog>
            <parent i:type="d:string">false</parent>
            <webServiceHandleName i:type="d:string">HDInfoServices</webServiceHandleName>
            <methodName i:type="d:string">GetMatchingDistrictList</methodName>
            <paramStr i:type="d:string">&lt;Parms&gt;&lt;Key&gt;5E4B7859-B805-474B-A833-FDB15D205D40&lt;/Key&gt;&lt;MatchToDistrictZipCode&gt;$zip&lt;/MatchToDistrictZipCode&gt;&lt;/Parms&gt;</paramStr>
            <webDBName i:type="d:string"></webDBName>
        </ProcessWebServiceRequestMultiWeb>
    </v:Body>
</v:Envelope>''';

      var headers = <String, String>{'Content-Type': 'text/xml'};

      final _dio = Dio(BaseOptions(validateStatus: (_) => true));
      var res = await _dio.post(
          'https://support.edupoint.com/Service/HDInfoCommunication.asmx',
          data: requestData,
          options: Options(headers: headers), onSendProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5);
        }
      }, onReceiveProgress: (one, two) {
        if (callback != null) {
          callback((one / two) * 0.5 + 0.5);
        }
      });
      resData = res.data;
    }
    // else {
    //   resData = MockResponses.ZipCodeResponse;
    // }

    final document = XmlDocument.parse(HtmlUnescape().convert(resData!));

    // print('${document.firstElementChild.firstElementChild.firstElementChild.firstElementChild.firstElementChild.firstElementChild.children[1].toString()}');

    return document.firstElementChild!.firstElementChild!.firstElementChild!
        .firstElementChild!.firstElementChild!.firstElementChild!.children
        .map((e) {
          return ZipCodeResult(
              address: e.getAttribute('Address'),
              districtName: e.getAttribute('Name'),
              districtUrl: e.getAttribute('PvueURL'));
        })
        .where((e) => e.districtUrl != null)
        .toList();
  }
}
