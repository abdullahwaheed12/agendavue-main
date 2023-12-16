// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SelectCategory {
  num id;
  String name;
  num accountId;
  String uuid;
  String startAt;
  dynamic gradingStandardId;
  bool isPublic;
  String createdAt;
  String courseCode;
  DefaultView defaultView;
  num rootAccountId;
  num enrollmentTermId;
  License license;
  dynamic gradePassbackSetting;
  dynamic endAt;
  bool publicSyllabus;
  bool publicSyllabusToAuth;
  num storageQuotaMb;
  bool isPublicToAuthUsers;
  bool homeroomCourse;
  dynamic courseColor;
  dynamic friendlyName;
  Term term;
  bool applyAssignmentGroupWeights;
  Calendar calendar;
  TimeZone timeZone;
  bool blueprint;
  bool template;
  List<Enrollment> enrollments;
  bool hideFinalGrades;
  WorkflowState workflowState;
  bool restrictEnrollmentsToCourseDates;
  String overriddenCourseVisibility;
  SelectCategory({
    required this.id,
    required this.name,
    required this.accountId,
    required this.uuid,
    required this.startAt,
    required this.gradingStandardId,
    required this.isPublic,
    required this.createdAt,
    required this.courseCode,
    required this.defaultView,
    required this.rootAccountId,
    required this.enrollmentTermId,
    required this.license,
    required this.gradePassbackSetting,
    required this.endAt,
    required this.publicSyllabus,
    required this.publicSyllabusToAuth,
    required this.storageQuotaMb,
    required this.isPublicToAuthUsers,
    required this.homeroomCourse,
    required this.courseColor,
    required this.friendlyName,
    required this.term,
    required this.applyAssignmentGroupWeights,
    required this.calendar,
    required this.timeZone,
    required this.blueprint,
    required this.template,
    required this.enrollments,
    required this.hideFinalGrades,
    required this.workflowState,
    required this.restrictEnrollmentsToCourseDates,
    required this.overriddenCourseVisibility,
  });

  factory SelectCategory.fromMap(Map<String, dynamic> map) {
    String name = (map["name"] ?? '') as String;

    //modify the name of the course

    // Store the original class name and create an empty string for the new class name
    String oldClassName = name;
    String newClassName = "";

    // Loop through the old class name and check for a dash (-)
    for (int i = 0; i < oldClassName.length; i++) {
      // If a dash is found, then create a new class name from the beginning of the string to the dash
      if (oldClassName[i] == "-") {
        newClassName = oldClassName.substring(0, i);
        // If the new class name is less than 6 characters, then add the rest of the string to the new class name and break the loop
        if (newClassName.length >= 6) {
          break;
        }
        // If a dash is not found, then the new class name is the same as the old class namesssssssssssssssssssssss
        else {
          newClassName = oldClassName;
        }
      }
    }
    name = newClassName;

    return SelectCategory(
      id: (map["id"] ?? 0.0) as num,
      name: name,
      accountId: (map["account_id"] ?? 0.0) as num,
      uuid: (map["uuid"] ?? '') as String,
      startAt: map["start_at"].toString(),
      gradingStandardId: map["grading_standard_id"],
      isPublic: (map["is_public"] ?? false) as bool,
      createdAt: map["created_at"].toString(),
      courseCode: (map["course_code"] ?? '') as String,
      defaultView: DefaultView.WIKI,
      rootAccountId: (map["root_account_id"] ?? 0.0) as num,
      enrollmentTermId: (map["enrollment_term_id"] ?? 0.0) as num,
      license: License.PRIVATE,
      gradePassbackSetting: map["grade_passback_setting"],
      endAt: map["end_at"],
      publicSyllabus: (map["public_syllabus"] ?? false) as bool,
      publicSyllabusToAuth: (map["public_syllabus_to_auth"] ?? false) as bool,
      storageQuotaMb: (map["storage_quota_mb"] ?? 0) as num,
      isPublicToAuthUsers: (map["is_public_to_auth_users"] ?? false) as bool,
      homeroomCourse: (map["homeroom_course"] ?? false) as bool,
      courseColor: map["course_color"],
      friendlyName: map["friendly_name"],
      term: Term.fromMap((map["term"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
      applyAssignmentGroupWeights:
          (map["apply_assignment_group_weights"] ?? false) as bool,
      calendar: Calendar.fromMap((map["calendar"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
      timeZone: TimeZone.AMERICA_NEW_YORK,
      blueprint: (map["blueprint"] ?? false) as bool,
      template: (map["template"] ?? false) as bool,
      enrollments: List<Enrollment>.from(
        ((map['enrollments'] ?? const <Enrollment>[]) as List)
            .map<Enrollment>((x) {
          return Enrollment.fromMap(
              (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
      hideFinalGrades: (map["hide_final_grades"] ?? false) as bool,
      workflowState: WorkflowState.AVAILABLE,
      restrictEnrollmentsToCourseDates:
          (map["restrict_enrollments_to_course_dates"] ?? false) as bool,
      overriddenCourseVisibility:
          (map["overridden_course_visibility"] ?? '') as String,
    );
  }

  factory SelectCategory.fromJson(String source) =>
      SelectCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SelectCategory(id: $id, name: $name, accountId: $accountId, uuid: $uuid, startAt: $startAt, gradingStandardId: $gradingStandardId, isPublic: $isPublic, createdAt: $createdAt, courseCode: $courseCode, defaultView: $defaultView, rootAccountId: $rootAccountId, enrollmentTermId: $enrollmentTermId, license: $license, gradePassbackSetting: $gradePassbackSetting, endAt: $endAt, publicSyllabus: $publicSyllabus, publicSyllabusToAuth: $publicSyllabusToAuth, storageQuotaMb: $storageQuotaMb, isPublicToAuthUsers: $isPublicToAuthUsers, homeroomCourse: $homeroomCourse, courseColor: $courseColor, friendlyName: $friendlyName, term: $term, applyAssignmentGroupWeights: $applyAssignmentGroupWeights, calendar: $calendar, timeZone: $timeZone, blueprint: $blueprint, template: $template, enrollments: $enrollments, hideFinalGrades: $hideFinalGrades, workflowState: $workflowState, restrictEnrollmentsToCourseDates: $restrictEnrollmentsToCourseDates, overriddenCourseVisibility: $overriddenCourseVisibility)';
  }
}

class Calendar {
  String ics;
  Calendar({
    required this.ics,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ics': ics,
    };
  }

  factory Calendar.fromMap(Map<String, dynamic> map) {
    return Calendar(
      ics: (map["ics"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Calendar.fromJson(String source) =>
      Calendar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Calendar(ics: $ics)';
}

enum DefaultView { WIKI }

class Enrollment {
  Type type;
  Role role;
  num roleId;
  num userId;
  State enrollmentState;
  bool limitPrivilegesToCourseSection;
  Enrollment({
    required this.type,
    required this.role,
    required this.roleId,
    required this.userId,
    required this.enrollmentState,
    required this.limitPrivilegesToCourseSection,
  });

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      type: Type.STUDENT,
      role: Role.STUDENT_ENROLLMENT,
      roleId: (map["roleId"] ?? 0.0) as num,
      userId: (map["userId"] ?? 0.0) as num,
      enrollmentState: State.ACTIVE,
      limitPrivilegesToCourseSection:
          (map["limit_privileges_to_course_section"] ?? false) as bool,
    );
  }

  factory Enrollment.fromJson(String source) =>
      Enrollment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enrollment(type: $type, role: $role, roleId: $roleId, userId: $userId, enrollmentState: $enrollmentState, limitPrivilegesToCourseSection: $limitPrivilegesToCourseSection)';
  }
}

enum State { ACTIVE }

enum Role { STUDENT_ENROLLMENT }

enum Type { STUDENT }

enum License { PRIVATE }

class Term {
  num id;
  String name;
  dynamic startAt;
  dynamic endAt;
  String createdAt;
  State workflowState;
  dynamic gradingPeriodGroupId;
  Term({
    required this.id,
    required this.name,
    required this.startAt,
    required this.endAt,
    required this.createdAt,
    required this.workflowState,
    required this.gradingPeriodGroupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start_at': startAt.millisecondsSinceEpoch,
      'end_at': endAt.millisecondsSinceEpoch,
      'created_at': createdAt,
      'workflow_state': workflowState.name,
      'grading_period_group_id': gradingPeriodGroupId,
    };
  }

  factory Term.fromMap(Map<String, dynamic> map) {
    return Term(
      id: (map["id"] ?? 0.0) as num,
      name: (map["name"] ?? '') as String,
      startAt: map["start_at"].toString(),
      endAt: map["end_at"].toString(),
      createdAt: map["created_at"],
      workflowState: State.ACTIVE,
      gradingPeriodGroupId: (map["grading_period_group_id"] ?? 0.0) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Term.fromJson(String source) =>
      Term.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Term(id: $id, name: $name, startAt: $startAt, endAt: $endAt, createdAt: $createdAt, workflowState: $workflowState, gradingPeriodGroupId: $gradingPeriodGroupId)';
  }

  @override
  bool operator ==(covariant Term other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.startAt == startAt &&
        other.endAt == endAt &&
        other.createdAt == createdAt &&
        other.workflowState == workflowState &&
        other.gradingPeriodGroupId == gradingPeriodGroupId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        startAt.hashCode ^
        endAt.hashCode ^
        createdAt.hashCode ^
        workflowState.hashCode ^
        gradingPeriodGroupId.hashCode;
  }
}

enum TimeZone { AMERICA_NEW_YORK }

enum WorkflowState { AVAILABLE }
