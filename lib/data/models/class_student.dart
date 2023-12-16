// To parse  this JSON data, do
//
//     final classStudent = classStudentFromJson(jsonString);

import 'dart:convert';

List<ClassStudent> classStudentFromJson(String str) => List<ClassStudent>.from(
    json.decode(str).map((x) => ClassStudent.fromJson(x)));

String classStudentToJson(List<ClassStudent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassStudent {
  ClassStudent({
    this.id,
    this.name,
    this.createdAt,
    this.sortableName,
    this.shortName,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  String? sortableName;
  String? shortName;

  factory ClassStudent.fromJson(Map<String, dynamic> json) => ClassStudent(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        sortableName: json["sortable_name"].replaceAll('(Student)', ''),
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "sortable_name": sortableName,
        "short_name": shortName,
      };
}
