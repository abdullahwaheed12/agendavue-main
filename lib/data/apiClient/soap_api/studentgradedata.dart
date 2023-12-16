class StudentGradeData {
  List<SchoolClass>? classes;
  String? studentName;
  List<ReportingPeriods>? reportingPeriods;
  String? currentMp;
  String? error;

  StudentGradeData({this.classes, this.studentName});

  @override
  String toString() {
    return 'StudentGradeData{classes: $classes, studentName: $studentName} reportingPeriods: $reportingPeriods currentMp : $currentMp';
  }
}

class ReportingPeriods {
  String name;
  String value;
  ReportingPeriods({required this.name, required this.value});
}

class SchoolClass {
  String? className,
      classTeacher,
      classTeacherEmail,
      markingPeriod,
      roomNumber,
      pctGrade,
      letterGrade;
  double? earnedPoints, possiblePoints;
  int? period;
  List<AssignmentCategory>? assignmentCategories;
  List<Assignment>? assignments;

  SchoolClass(
      {this.className,
      this.classTeacher,
      this.classTeacherEmail,
      this.markingPeriod,
      this.period,
      this.earnedPoints,
      this.possiblePoints,
      this.assignmentCategories,
      this.assignments});

  @override
  String toString() {
    return 'SchoolClass{className: $className, classTeacher: $classTeacher, classTeacherEmail: $classTeacherEmail, markingPeriod: $markingPeriod, roomNumber: $roomNumber, pctGrade: $pctGrade, earnedPoints: $earnedPoints, possiblePoints: $possiblePoints, period: $period, assignmentCategories: $assignmentCategories, assignments: $assignments}';
  }
}

class Assignment {
  String? assignmentName, date, category, notes;
  // earn points = -1 means grade not added
  double? earnedPoints, possiblePoints;

  Assignment(
      {this.assignmentName,
      this.date,
      this.earnedPoints,
      this.possiblePoints,
      this.notes});

  @override
  String toString() {
    return 'Assignment{assignmentName: $assignmentName, date: $date, category: $category, earnedPoints: $earnedPoints, possiblePoints: $possiblePoints, notes: $notes}';
  }
}

class AssignmentCategory {
  double? earnedPoints;
  double? possiblePoints;
  double? weight;
  String? name;

  AssignmentCategory(
      {this.name, this.weight, this.earnedPoints, this.possiblePoints});

  @override
  String toString() {
    return 'AssignmentCategory{earnedPoints: $earnedPoints, possiblePoints: $possiblePoints, weight: $weight, name: $name}';
  }
}
