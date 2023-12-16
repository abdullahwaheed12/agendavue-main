// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentInfo {
  String? name;
  String? subject;
  String? period;
  String? roomNo;
  String? canvasId;
  DateTime? start;
  DateTime? end;
  String? teacherName;
  String? assignments;
  String? grades;
  String? studentNames;
  StudentInfo({
    this.name,
    this.subject,
    this.period,
    this.roomNo,
    this.canvasId,
    this.start,
    this.end,
    this.teacherName,
    this.assignments,
    this.grades,
    this.studentNames,
  });

  StudentInfo copyWith({
    String? name,
    String? subject,
    String? period,
    String? roomNo,
    String? canvasId,
    DateTime? start,
    DateTime? end,
    String? teacherName,
    String? assignments,
    String? grades,
    String? studentNames,
  }) {
    return StudentInfo(
      name: name ?? this.name,
      subject: subject ?? this.subject,
      period: period ?? this.period,
      roomNo: roomNo ?? this.roomNo,
      canvasId: canvasId ?? this.canvasId,
      start: start ?? this.start,
      end: end ?? this.end,
      teacherName: teacherName ?? this.teacherName,
      assignments: assignments ?? this.assignments,
      grades: grades ?? this.grades,
      studentNames: studentNames ?? this.studentNames,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'subject': subject,
      'period': period,
      'roomNo': roomNo,
      'canvasId': canvasId,
      'start': start?.millisecondsSinceEpoch,
      'end': end?.millisecondsSinceEpoch,
      'teacherName': teacherName,
      'assignments': assignments,
      'grades': grades,
      'studentNames': studentNames,
    };
  }

  factory StudentInfo.fromMap(Map<String, dynamic> map) {
    return StudentInfo(
      name: map['name'] != null ? map["name"] ?? '' : null,
      subject: map['subject'] != null ? map["subject"] ?? '' : null,
      period: map['period'] != null ? map["period"] ?? '' : null,
      roomNo: map['roomNo'] != null ? map["roomNo"] ?? '' : null,
      canvasId: map['canvasId'] != null ? map["canvasId"] ?? '' : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["start"] ?? 0) ?? 0)
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["end"] ?? 0) ?? 0)
          : null,
      teacherName: map['teacherName'] != null ? map["teacherName"] ?? '' : null,
      assignments: map['assignments'] != null ? map["assignments"] ?? '' : null,
      grades: map['grades'] != null ? map["grades"] ?? '' : null,
      studentNames:
          map['studentNames'] != null ? map["studentNames"] ?? '' : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentInfo.fromJson(String source) =>
      StudentInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentInfo(name: $name, subject: $subject, period: $period, roomNo: $roomNo, canvasId: $canvasId, start: $start, end: $end, teacherName: $teacherName, assignments: $assignments, grades: $grades, studentNames: $studentNames)';
  }

  @override
  bool operator ==(covariant StudentInfo other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.subject == subject &&
        other.period == period &&
        other.roomNo == roomNo &&
        other.canvasId == canvasId &&
        other.start == start &&
        other.end == end &&
        other.teacherName == teacherName &&
        other.assignments == assignments &&
        other.grades == grades &&
        other.studentNames == studentNames;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        subject.hashCode ^
        period.hashCode ^
        roomNo.hashCode ^
        canvasId.hashCode ^
        start.hashCode ^
        end.hashCode ^
        teacherName.hashCode ^
        assignments.hashCode ^
        grades.hashCode ^
        studentNames.hashCode;
  }
}
