import 'dart:developer';

import 'package:agendavue/core/app_export.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/apiClient/soap_api/studentdata.dart';
import '../data/apiClient/soap_api/studentgradedata.dart';
import '../data/apiClient/soap_api/studentvueclient_base.dart';
import '../data/apiClient/studentApiCall.dart';
import '../data/models/class_schedule.dart';
import '../data/models/select_category.dart';
import '../data/models/todo.dart';
import '../data/models/upcomming_events.dart';

class GeneralController extends GetxController {
  StudentVueClient? client;
  StudentGradeData? grades;
  StudentData? studentData;
  List<Todo>? todoData;
  List<StudentGradeData> listOfGrades = [];
  List<ClassInfo>? classInfo;
  List<SelectCategory>? studentDataFromCategory;
  List<StudentUpCommingEventModel>? studentUpCommingEventModel;
  List? studentAnnouncemnet;
  //default domainUrl  'md-mcps-psv.edupoint.com'
  Future loadNewGradeBookk(String termIndex) async {
    var usernameStorage = GetStorage().read(usernameKey);
    var passwordKeyStorage = GetStorage().read(passwordKey);
    var districtDomainUrl = GetStorage().read(districtDomainUrlKey);

    client = StudentVueClient(
        usernameStorage, passwordKeyStorage, districtDomainUrl,
        mock: false);

    listOfGrades.add(await client!.loadGradebook(termIndex: termIndex));
    update();
  }

  getStudentData(String userName, String password, String domainUrl) async {
    client = StudentVueClient(userName, password, domainUrl, mock: true);

    grades = await client!.loadGradebook();
    listOfGrades.add(grades!);
    grades!.reportingPeriods!.forEach((element) {
      loadNewGradeBookk(element.value);
    });
    print('currentMp ${grades!.currentMp ?? ''}');
    print('reportingPeriods ${grades!.reportingPeriods ?? ''}');
    print('listOfGrades $listOfGrades');
    studentData = await client!.loadStudentData();
    print('studentData $studentData');
    classInfo = await client!.loadStudentClassList();
    print('classInfo : $classInfo');
    print('studentData : $studentData');
    StudentApiCall.getStuddentDataForSelectCatefory();
    StudentApiCall.getStuddentTodoData();
    StudentApiCall.getStuddentUpCoomingEventsData();
    StudentApiCall.getAnnouncemnet();
    studentDataFromCategory = StudentApiCall.studentDataFromCategory;
    studentAnnouncemnet = StudentApiCall.studentAnnouncemnet;
    log('studentDataFromCategory');
    print(studentDataFromCategory);
    studentUpCommingEventModel = StudentApiCall.studentUpCommingEventModel;
    log('studentUpCommingEventModel');
    print(studentUpCommingEventModel);
    todoData = StudentApiCall.todoData;
    log('todo');
    print(todoData);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var usernameStorage = GetStorage().read(usernameKey);
    var passwordKeyStorage = GetStorage().read(passwordKey);
    var districtDomainUrl = GetStorage().read(districtDomainUrlKey);

    if (usernameStorage != null && passwordKeyStorage != null) {
      getStudentData(
          usernameStorage, passwordKeyStorage, districtDomainUrl ?? '');
    }
  }
}
