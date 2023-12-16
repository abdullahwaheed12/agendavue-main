// To parse this JSON data, do
//
// final classSchedule = classScheduleFromMap(jsonString);

import 'dart:convert';

class ClassSchedule {
  ClassSchedule({
    this.studentClassSchedule,
    this.omitXmlDeclaration,
  });

  StudentClassSchedule? studentClassSchedule;
  String? omitXmlDeclaration;

  factory ClassSchedule.fromJson(String str) =>
      ClassSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassSchedule.fromMap(Map<String, dynamic> json) => ClassSchedule(
        studentClassSchedule: json["StudentClassSchedule"] == null
            ? null
            : StudentClassSchedule.fromMap(json["StudentClassSchedule"]),
        omitXmlDeclaration: json["#omit-xml-declaration"] == null
            ? null
            : json["#omit-xml-declaration"],
      );

  Map<String, dynamic> toMap() => {
        "StudentClassSchedule":
            studentClassSchedule == null ? null : studentClassSchedule?.toMap(),
        "#omit-xml-declaration":
            omitXmlDeclaration == null ? null : omitXmlDeclaration,
      };
}

class StudentClassSchedule {
  StudentClassSchedule({
    this.xmlnsXsd,
    this.xmlnsXsi,
    this.termIndex,
    this.termIndexName,
    this.errorMessage,
    this.includeAdditionalStaffWhenEmailingTeachers,
    this.todayScheduleInfoData,
    this.classLists,
    this.termLists,
    this.concurrentSchoolStudentClassSchedules,
  });

  String? xmlnsXsd;
  String? xmlnsXsi;
  String? termIndex;
  String? termIndexName;
  String? errorMessage;
  String? includeAdditionalStaffWhenEmailingTeachers;
  TodayScheduleInfoData? todayScheduleInfoData;
  ClassLists? classLists;
  TermLists? termLists;
  ConcurrentSchoolStudentClassSchedules? concurrentSchoolStudentClassSchedules;

  factory StudentClassSchedule.fromJson(String str) =>
      StudentClassSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StudentClassSchedule.fromMap(Map<String, dynamic> json) =>
      StudentClassSchedule(
        xmlnsXsd: json["-xmlns:xsd"] == null ? null : json["-xmlns:xsd"],
        xmlnsXsi: json["-xmlns:xsi"] == null ? null : json["-xmlns:xsi"],
        termIndex: json["-TermIndex"] == null ? null : json["-TermIndex"],
        termIndexName:
            json["-TermIndexName"] == null ? null : json["-TermIndexName"],
        errorMessage:
            json["-ErrorMessage"] == null ? null : json["-ErrorMessage"],
        includeAdditionalStaffWhenEmailingTeachers:
            json["-IncludeAdditionalStaffWhenEmailingTeachers"] == null
                ? null
                : json["-IncludeAdditionalStaffWhenEmailingTeachers"],
        todayScheduleInfoData: json["TodayScheduleInfoData"] == null
            ? null
            : TodayScheduleInfoData.fromMap(json["TodayScheduleInfoData"]),
        classLists: json["ClassLists"] == null
            ? null
            : ClassLists.fromMap(json["ClassLists"]),
        termLists: json["TermLists"] == null
            ? null
            : TermLists.fromMap(json["TermLists"]),
        concurrentSchoolStudentClassSchedules:
            json["ConcurrentSchoolStudentClassSchedules"] == null
                ? null
                : ConcurrentSchoolStudentClassSchedules.fromMap(
                    json["ConcurrentSchoolStudentClassSchedules"]),
      );

  Map<String, dynamic> toMap() => {
        "-xmlns:xsd": xmlnsXsd == null ? null : xmlnsXsd,
        "-xmlns:xsi": xmlnsXsi == null ? null : xmlnsXsi,
        "-TermIndex": termIndex == null ? null : termIndex,
        "-TermIndexName": termIndexName == null ? null : termIndexName,
        "-ErrorMessage": errorMessage == null ? null : errorMessage,
        "-IncludeAdditionalStaffWhenEmailingTeachers":
            includeAdditionalStaffWhenEmailingTeachers == null
                ? null
                : includeAdditionalStaffWhenEmailingTeachers,
        "TodayScheduleInfoData": todayScheduleInfoData == null
            ? null
            : todayScheduleInfoData?.toMap(),
        "ClassLists": classLists == null ? null : classLists?.toMap(),
        "TermLists": termLists == null ? null : termLists?.toMap(),
        "ConcurrentSchoolStudentClassSchedules":
            concurrentSchoolStudentClassSchedules == null
                ? null
                : concurrentSchoolStudentClassSchedules?.toMap(),
      };
}

class ClassLists {
  ClassLists({
    this.classListing,
  });

  List<ClassListing>? classListing;

  factory ClassLists.fromJson(String str) =>
      ClassLists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassLists.fromMap(Map<String, dynamic> json) => ClassLists(
        classListing: json["ClassListing"] == null
            ? null
            : List<ClassListing>.from(
                json["ClassListing"].map((x) => ClassListing.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ClassListing": classListing == null
            ? null
            : List<dynamic>.from(classListing!.map((x) => x.toMap())),
      };
}

class ClassListing {
  ClassListing({
    this.period,
    this.courseTitle,
    this.roomName,
    this.teacher,
    this.teacherEmail,
    this.sectionGu,
    this.teacherStaffGu,
    this.additionalStaffInformationXmLs,
  });

  String? period;
  String? courseTitle;
  String? roomName;
  String? teacher;
  String? teacherEmail;
  String? sectionGu;
  String? teacherStaffGu;
  ConcurrentSchoolStudentClassSchedules? additionalStaffInformationXmLs;

  factory ClassListing.fromJson(String str) =>
      ClassListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassListing.fromMap(Map<String, dynamic> json) => ClassListing(
        period: json["-Period"] == null ? null : json["-Period"],
        courseTitle: json["-CourseTitle"] == null ? null : json["-CourseTitle"],
        roomName: json["-RoomName"] == null ? null : json["-RoomName"],
        teacher: json["-Teacher"] == null ? null : json["-Teacher"],
        teacherEmail:
            json["-TeacherEmail"] == null ? null : json["-TeacherEmail"],
        sectionGu: json["-SectionGU"] == null ? null : json["-SectionGU"],
        teacherStaffGu:
            json["-TeacherStaffGU"] == null ? null : json["-TeacherStaffGU"],
        additionalStaffInformationXmLs:
            json["AdditionalStaffInformationXMLs"] == null
                ? null
                : ConcurrentSchoolStudentClassSchedules.fromMap(
                    json["AdditionalStaffInformationXMLs"]),
      );

  Map<String, dynamic> toMap() => {
        "-Period": period == null ? null : period,
        "-CourseTitle": courseTitle == null ? null : courseTitle,
        "-RoomName": roomName == null ? null : roomName,
        "-Teacher": teacher == null ? null : teacher,
        "-TeacherEmail": teacherEmail == null ? null : teacherEmail,
        "-SectionGU": sectionGu == null ? null : sectionGu,
        "-TeacherStaffGU": teacherStaffGu == null ? null : teacherStaffGu,
        "AdditionalStaffInformationXMLs": additionalStaffInformationXmLs == null
            ? null
            : additionalStaffInformationXmLs?.toMap(),
      };
}

class ConcurrentSchoolStudentClassSchedules {
  ConcurrentSchoolStudentClassSchedules({
    this.selfClosing,
  });

  String? selfClosing;

  factory ConcurrentSchoolStudentClassSchedules.fromJson(String str) =>
      ConcurrentSchoolStudentClassSchedules.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConcurrentSchoolStudentClassSchedules.fromMap(
          Map<String, dynamic> json) =>
      ConcurrentSchoolStudentClassSchedules(
        selfClosing:
            json["-self-closing"] == null ? null : json["-self-closing"],
      );

  Map<String, dynamic> toMap() => {
        "-self-closing": selfClosing == null ? null : selfClosing,
      };
}

class TermLists {
  TermLists({
    this.termListing,
  });

  List<TermListing>? termListing;

  factory TermLists.fromJson(String str) => TermLists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TermLists.fromMap(Map<String, dynamic> json) => TermLists(
        termListing: json["TermListing"] == null
            ? null
            : List<TermListing>.from(
                json["TermListing"].map((x) => TermListing.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TermListing": termListing == null
            ? null
            : List<dynamic>.from(termListing!.map((x) => x.toMap())),
      };
}

class TermListing {
  TermListing({
    this.termIndex,
    this.termCode,
    this.termName,
    this.beginDate,
    this.endDate,
    this.schoolYearTrmCodeGu,
    this.termDefCodes,
  });

  String? termIndex;
  String? termCode;
  String? termName;
  String? beginDate;
  String? endDate;
  String? schoolYearTrmCodeGu;
  TermDefCodes? termDefCodes;

  factory TermListing.fromJson(String str) =>
      TermListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TermListing.fromMap(Map<String, dynamic> json) => TermListing(
        termIndex: json["-TermIndex"] == null ? null : json["-TermIndex"],
        termCode: json["-TermCode"] == null ? null : json["-TermCode"],
        termName: json["-TermName"] == null ? null : json["-TermName"],
        beginDate: json["-BeginDate"] == null ? null : json["-BeginDate"],
        endDate: json["-EndDate"] == null ? null : json["-EndDate"],
        schoolYearTrmCodeGu: json["-SchoolYearTrmCodeGU"] == null
            ? null
            : json["-SchoolYearTrmCodeGU"],
        termDefCodes: json["TermDefCodes"] == null
            ? null
            : TermDefCodes.fromMap(json["TermDefCodes"]),
      );

  Map<String, dynamic> toMap() => {
        "-TermIndex": termIndex == null ? null : termIndex,
        "-TermCode": termCode == null ? null : termCode,
        "-TermName": termName == null ? null : termName,
        "-BeginDate": beginDate == null ? null : beginDate,
        "-EndDate": endDate == null ? null : endDate,
        "-SchoolYearTrmCodeGU":
            schoolYearTrmCodeGu == null ? null : schoolYearTrmCodeGu,
        "TermDefCodes": termDefCodes == null ? null : termDefCodes!.toMap(),
      };
}

class TermDefCodes {
  TermDefCodes({
    this.termDefCode,
  });

  List<TermDefCode>? termDefCode;

  factory TermDefCodes.fromJson(String str) =>
      TermDefCodes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TermDefCodes.fromMap(Map<String, dynamic> json) => TermDefCodes(
        termDefCode: json["TermDefCode"] == null
            ? null
            : List<TermDefCode>.from(
                json["TermDefCode"].map((x) => TermDefCode.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TermDefCode": termDefCode == null
            ? null
            : List<dynamic>.from(termDefCode!.map((x) => x.toMap())),
      };
}

class TermDefCode {
  TermDefCode({
    this.termDefName,
    this.selfClosing,
  });

  String? termDefName;
  String? selfClosing;

  factory TermDefCode.fromJson(String str) =>
      TermDefCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TermDefCode.fromMap(Map<String, dynamic> json) => TermDefCode(
        termDefName: json["-TermDefName"] == null ? null : json["-TermDefName"],
        selfClosing:
            json["-self-closing"] == null ? null : json["-self-closing"],
      );

  Map<String, dynamic> toMap() => {
        "-TermDefName": termDefName == null ? null : termDefName,
        "-self-closing": selfClosing == null ? null : selfClosing,
      };
}

class TodayScheduleInfoData {
  TodayScheduleInfoData({
    this.date,
    this.schoolInfos,
  });

  String? date;
  SchoolInfos? schoolInfos;

  factory TodayScheduleInfoData.fromJson(String str) =>
      TodayScheduleInfoData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodayScheduleInfoData.fromMap(Map<String, dynamic> json) =>
      TodayScheduleInfoData(
        date: json["-Date"] == null ? null : json["-Date"],
        schoolInfos: json["SchoolInfos"] == null
            ? null
            : SchoolInfos.fromMap(json["SchoolInfos"]),
      );

  Map<String, dynamic> toMap() => {
        "-Date": date == null ? null : date,
        "SchoolInfos": schoolInfos == null ? null : schoolInfos!.toMap(),
      };
}

class SchoolInfos {
  SchoolInfos({
    this.schoolInfo,
  });

  SchoolInfo? schoolInfo;

  factory SchoolInfos.fromJson(String str) =>
      SchoolInfos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SchoolInfos.fromMap(Map<String, dynamic> json) => SchoolInfos(
        schoolInfo: json["SchoolInfo"] == null
            ? null
            : SchoolInfo.fromMap(json["SchoolInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "SchoolInfo": schoolInfo == null ? null : schoolInfo!.toMap(),
      };
}

class SchoolInfo {
  SchoolInfo({
    this.schoolName,
    this.bellSchedName,
    this.classes,
  });

  String? schoolName;
  String? bellSchedName;
  Classes? classes;

  factory SchoolInfo.fromJson(String str) =>
      SchoolInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SchoolInfo.fromMap(Map<String, dynamic> json) => SchoolInfo(
        schoolName: json["-SchoolName"] == null ? null : json["-SchoolName"],
        bellSchedName:
            json["-BellSchedName"] == null ? null : json["-BellSchedName"],
        classes:
            json["Classes"] == null ? null : Classes.fromMap(json["Classes"]),
      );

  Map<String, dynamic> toMap() => {
        "-SchoolName": schoolName == null ? null : schoolName,
        "-BellSchedName": bellSchedName == null ? null : bellSchedName,
        "Classes": classes == null ? null : classes!.toMap(),
      };
}

class Classes {
  Classes({
    this.classInfo,
  });

  List<ClassInfo>? classInfo;

  factory Classes.fromJson(String str) => Classes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Classes.fromMap(Map<String, dynamic> json) => Classes(
        classInfo: json["ClassInfo"] == null
            ? null
            : List<ClassInfo>.from(
                json["ClassInfo"].map((x) => ClassInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ClassInfo": classInfo == null
            ? null
            : List<dynamic>.from(classInfo!.map((x) => x.toMap())),
      };
}

class ClassInfo {
  ClassInfo({
    this.period,
    this.className,
    this.classUrl,
    this.startTime,
    this.endTime,
    this.teacherName,
    this.teacherUrl,
    this.roomName,
    this.teacherEmail,
    this.emailSubject,
    this.staffGu,
    this.endDate,
    this.startDate,
    this.sectionGu,
    this.hideClassStartEndTime,
    this.attendanceCode,
  });

  String? period;
  String? className;
  String? classUrl;
  String? startTime;
  String? endTime;
  String? teacherName;
  String? teacherUrl;
  String? roomName;
  String? teacherEmail;
  String? emailSubject;
  String? staffGu;
  String? endDate;
  String? startDate;
  String? sectionGu;
  String? hideClassStartEndTime;
  ConcurrentSchoolStudentClassSchedules? attendanceCode;

  factory ClassInfo.fromJson(String str) => ClassInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassInfo.fromMap(Map<String, dynamic> json) => ClassInfo(
        period: json["-Period"] == null ? null : json["-Period"],
        className: json["-ClassName"] == null ? null : json["-ClassName"],
        classUrl: json["-ClassURL"] == null ? null : json["-ClassURL"],
        startTime: json["-StartTime"] == null ? null : json["-StartTime"],
        endTime: json["-EndTime"] == null ? null : json["-EndTime"],
        teacherName: json["-TeacherName"] == null ? null : json["-TeacherName"],
        teacherUrl: json["-TeacherURL"] == null ? null : json["-TeacherURL"],
        roomName: json["-RoomName"] == null ? null : json["-RoomName"],
        teacherEmail:
            json["-TeacherEmail"] == null ? null : json["-TeacherEmail"],
        emailSubject:
            json["-EmailSubject"] == null ? null : json["-EmailSubject"],
        staffGu: json["-StaffGU"] == null ? null : json["-StaffGU"],
        endDate: json["-EndDate"] == null ? null : json["-EndDate"],
        startDate: json["-StartDate"] == null ? null : json["-StartDate"],
        sectionGu: json["-SectionGU"] == null ? null : json["-SectionGU"],
        hideClassStartEndTime: json["-HideClassStartEndTime"] == null
            ? null
            : json["-HideClassStartEndTime"],
        attendanceCode: json["AttendanceCode"] == null
            ? null
            : ConcurrentSchoolStudentClassSchedules.fromMap(
                json["AttendanceCode"]),
      );

  Map<String, dynamic> toMap() => {
        "-Period": period == null ? null : period,
        "-ClassName": className == null ? null : className,
        "-ClassURL": classUrl == null ? null : classUrl,
        "-StartTime": startTime == null ? null : startTime,
        "-EndTime": endTime == null ? null : endTime,
        "-TeacherName": teacherName == null ? null : teacherName,
        "-TeacherURL": teacherUrl == null ? null : teacherUrl,
        "-RoomName": roomName == null ? null : roomName,
        "-TeacherEmail": teacherEmail == null ? null : teacherEmail,
        "-EmailSubject": emailSubject == null ? null : emailSubject,
        "-StaffGU": staffGu == null ? null : staffGu,
        "-EndDate": endDate == null ? null : endDate,
        "-StartDate": startDate == null ? null : startDate,
        "-SectionGU": sectionGu == null ? null : sectionGu,
        "-HideClassStartEndTime":
            hideClassStartEndTime == null ? null : hideClassStartEndTime,
        "AttendanceCode":
            attendanceCode == null ? null : attendanceCode!.toMap(),
      };
  @override
  String toString() {
    return 'period: $period, className: $className, classUrl: $classUrl, startTime: $startTime, endTime: $endTime,';
  }
}
