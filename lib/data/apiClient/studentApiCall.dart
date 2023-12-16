import 'dart:convert';
import 'dart:developer';

import 'package:agendavue/data/apiClient/student_data_configration.dart';
import 'package:agendavue/data/models/todo.dart';
import 'package:http/http.dart' as http;

import '../models/class_student.dart';
import '../models/select_category.dart';
import '../models/upcomming_events.dart';

class StudentApiCall {
  static List<SelectCategory>? studentDataFromCategory;
  //sign in hony k baad jo screen ati hai us mai dropdown ha us k liye data is api sy aye ga
  static Future<List<SelectCategory>> getStuddentDataForSelectCatefory() async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $ktoken'
    };
    try {
      final response = await http.get(
        Uri.parse(
            'https://canvas.instructure.com/api/v1/courses?enrollment_type=student&enrollment_state=active&include[]=term&state[]=available'),
        headers: header,
      );
      if (response.statusCode == 200) {
        List decodeData = jsonDecode(response.body);
        studentDataFromCategory = decodeData
            .map(
              (e) => SelectCategory.fromMap(e),
            )
            .toList();
        return studentDataFromCategory!;
      }
      return [];
    } catch (e) {
      print('catch ${e.toString()}');
      return [];
      // print(e);
    }
  }

  static List<Todo>? todoData;
  static List<Todo> missing = [];
  static List<Todo> complete = [];
  // home screen per jo todo work ho ga today assignment us ka data is api sy aye ga
  static Future<List<Todo>> getStuddentTodoData() async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $ktoken'
    };
    try {
      final response = await http.get(
        Uri.parse('https://mcpsmd.instructure.com/api/v1/users/self/todo'),
        headers: header,
      );
      if (response.statusCode == 200) {
        todoData = todoFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }

    return todoData!;
  }

  static List<StudentUpCommingEventModel>? studentUpCommingEventModel;
  // home screen per jo tomorrow asignmet section  us ka data is api sy aye ga

  static Future<List<StudentUpCommingEventModel>>
      getStuddentUpCoomingEventsData() async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $ktoken'
    };
    try {
      final response = await http.get(
        Uri.parse(
            'https://mcpsmd.instructure.com/api/v1/users/self/upcoming_events'),
        headers: header,
      );
      if (response.statusCode == 200) {
        studentUpCommingEventModel =
            studentUpCommingEventModelFromJson(response.body);
        log('studentUpCommingEventModel $studentUpCommingEventModel');

        print('studentUpCommingEventModel $studentUpCommingEventModel');
      }
    } catch (e) {
      print('exception in tommorow ${e.toString()}');
    }
    return studentUpCommingEventModel!;
  }

  static List? studentAnnouncemnet;
  // announcement ka data is api sy aye ga
  static getAnnouncemnet() async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $ktoken'
    };
    try {
      final response = await http.get(
        Uri.parse(
            'https://mcpsmd.instructure.com/api/v1/users/self/activity_stream?only_active_courses=true'),
        headers: header,
      );
      if (response.statusCode == 200) {
        studentAnnouncemnet = json.decode(response.body);

        print('studentAnnouncemnet $studentAnnouncemnet');
      }
    } catch (e) {
      print(e);
    }
  }

  static List<ClassStudent>? classStudent;
  static Future<List<ClassStudent>?> getClassStudent(String courseId) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $ktoken'
    };
    try {
      final response = await http.get(
        Uri.parse(
            'https://mcpsmd.instructure.com/api/v1/courses/$courseId/students'),
        headers: header,
      );
      //print('student class ${response.body}');

      if (response.statusCode == 200) {
        classStudent = classStudentFromJson(response.body);

        return classStudent;
      }
    } catch (e) {
      print('exception in getClassStudent $e');
    }

    return null;
  }
}
