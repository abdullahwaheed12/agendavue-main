// To parse required this JSON data, do
//
//     final studentUpCommingEventModel = studentUpCommingEventModelFromJson(jsonString);

import 'dart:convert';

List<StudentUpCommingEventModel> studentUpCommingEventModelFromJson(
        String str) =>
    List<StudentUpCommingEventModel>.from(
        json.decode(str).map((x) => StudentUpCommingEventModel.fromJson(x)));

class StudentUpCommingEventModel {
  StudentUpCommingEventModel({
    required this.title,
    required this.description,
    required this.submissionTypes,
    required this.workflowState,
    required this.createdAt,
    required this.updatedAt,
    required this.allDay,
    required this.allDayDate,
    required this.id,
    required this.type,
    required this.assignment,
    required this.htmlUrl,
    required this.contextCode,
    required this.contextName,
    required this.contextColor,
    required this.endAt,
    required this.startAt,
    required this.url,
    required this.importantDates,
    required this.lockInfo,
  });

  String? title;
  String? description;
  SubmissionType? submissionTypes;
  WorkflowState? workflowState;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? allDay;
  DateTime? allDayDate;
  String? id;
  Type? type;
  Assignment assignment;
  String? htmlUrl;
  String? contextCode;
  String? contextName;
  dynamic contextColor;
  DateTime? endAt;
  DateTime? startAt;
  String? url;
  bool? importantDates;
  LockInfo? lockInfo;

  factory StudentUpCommingEventModel.fromJson(Map<String, dynamic> json) =>
      StudentUpCommingEventModel(
        title: json["title"] ?? '',
        description: json["description"] == null ? null : json["description"],
        submissionTypes: submissionTypeValues.map[json["submission_types"]],
        workflowState: workflowStateValues.map[json["workflow_state"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        allDay: json["all_day"] ?? false,
        allDayDate: DateTime.parse(json["all_day_date"]),
        id: json["id"],
        type: typeValues.map[json["type"]],
        assignment: Assignment.fromJson(json["assignment"]),
        htmlUrl: json["html_url"] ?? '',
        contextCode: json["context_code"] ?? '',
        contextName: json["context_name"] ?? '',
        contextColor: json["context_color"] ?? '',
        endAt: DateTime.parse(json["end_at"]),
        startAt: DateTime.parse(json["start_at"]),
        url: json["url"] ?? '',
        importantDates: json["important_dates"] ?? false,
        lockInfo: json["lock_info"] == null
            ? null
            : LockInfo.fromJson(json["lock_info"]),
      );
}

class Assignment {
  Assignment({
    required this.id,
    required this.description,
    required this.dueAt,
    required this.unlockAt,
    required this.lockAt,
    required this.pointsPossible,
    required this.gradingType,
    required this.assignmentGroupId,
    required this.gradingStandardId,
    required this.createdAt,
    required this.updatedAt,
    required this.peerReviews,
    required this.automaticPeerReviews,
    required this.position,
    required this.gradeGroupStudentsIndividually,
    required this.anonymousPeerReviews,
    required this.groupCategoryId,
    required this.postToSis,
    required this.moderatedGrading,
    required this.omitFromFinalGrade,
    required this.intraGroupPeerReviews,
    required this.anonymousInstructorAnnotations,
    required this.anonymousGrading,
    required this.gradersAnonymousToGraders,
    required this.graderCount,
    required this.graderCommentsVisibleToGraders,
    required this.finalGraderId,
    required this.graderNamesVisibleToFinalGrader,
    required this.allowedAttempts,
    required this.annotatableAttachmentId,
    required this.secureParams,
    required this.ltiContextId,
    required this.courseId,
    required this.name,
    required this.submissionTypes,
    required this.hasSubmittedSubmissions,
    required this.dueDateRequired,
    required this.maxNameLength,
    required this.inClosedGradingPeriod,
    required this.gradedSubmissionsExist,
    required this.isQuizAssignment,
    required this.canDuplicate,
    required this.originalCourseId,
    required this.originalAssignmentId,
    required this.originalLtiResourceLinkId,
    required this.originalAssignmentName,
    required this.originalQuizId,
    required this.workflowState,
    required this.importantDates,
    required this.muted,
    required this.htmlUrl,
    required this.published,
    required this.onlyVisibleToOverrides,
    required this.lockedForUser,
    required this.submissionsDownloadUrl,
    required this.postManually,
    required this.anonymizeStudents,
    required this.requireLockdownBrowser,
    required this.lockInfo,
    required this.lockExplanation,
    required this.externalToolTagAttributes,
    required this.url,
    required this.isQuizLtiAssignment,
    required this.frozenAttributes,
  });

  int? id;
  String? description;
  DateTime dueAt;
  DateTime? unlockAt;
  DateTime? lockAt;
  num? pointsPossible;
  GradingType? gradingType;
  num? assignmentGroupId;
  dynamic gradingStandardId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? peerReviews;
  bool? automaticPeerReviews;
  num? position;
  bool? gradeGroupStudentsIndividually;
  bool? anonymousPeerReviews;
  dynamic groupCategoryId;
  bool? postToSis;
  bool? moderatedGrading;
  bool? omitFromFinalGrade;
  bool? intraGroupPeerReviews;
  bool? anonymousInstructorAnnotations;
  bool? anonymousGrading;
  bool? gradersAnonymousToGraders;
  num? graderCount;
  bool? graderCommentsVisibleToGraders;
  dynamic finalGraderId;
  bool? graderNamesVisibleToFinalGrader;
  num? allowedAttempts;
  dynamic annotatableAttachmentId;
  String? secureParams;
  String? ltiContextId;
  num? courseId;
  String name;
  List<SubmissionType?>? submissionTypes;
  bool? hasSubmittedSubmissions;
  bool? dueDateRequired;
  num maxNameLength;
  bool? inClosedGradingPeriod;
  bool? gradedSubmissionsExist;
  bool? isQuizAssignment;
  bool? canDuplicate;
  num? originalCourseId;
  num? originalAssignmentId;
  String? originalLtiResourceLinkId;
  String? originalAssignmentName;
  dynamic originalQuizId;
  WorkflowState? workflowState;
  bool? importantDates;
  bool? muted;
  String? htmlUrl;
  bool? published;
  bool? onlyVisibleToOverrides;
  bool? lockedForUser;
  String? submissionsDownloadUrl;
  bool? postManually;
  bool? anonymizeStudents;
  bool? requireLockdownBrowser;
  LockInfo? lockInfo;
  String? lockExplanation;
  ExternalToolTagAttributes? externalToolTagAttributes;
  dynamic url;
  bool? isQuizLtiAssignment;
  List<String>? frozenAttributes;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        description: json["description"] == null ? null : json["description"],
        dueAt: DateTime.parse(json["due_at"]),
        unlockAt: json["unlock_at"] == null
            ? null
            : DateTime.parse(json["unlock_at"]),
        lockAt:
            json["lock_at"] == null ? null : DateTime.parse(json["lock_at"]),
        pointsPossible: json["points_possible"] ?? 0,
        gradingType: gradingTypeValues.map[json["grading_type"]],
        assignmentGroupId: json["assignment_group_id"],
        gradingStandardId: json["grading_standard_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        peerReviews: json["peer_reviews"] ?? false,
        automaticPeerReviews: json["automatic_peer_reviews"] ?? false,
        position: json["position"],
        gradeGroupStudentsIndividually:
            json["grade_group_students_individually"] ?? false,
        anonymousPeerReviews: json["anonymous_peer_reviews"] ?? false,
        groupCategoryId: json["group_category_id"],
        postToSis: json["post_to_sis"] ?? false,
        moderatedGrading: json["moderated_grading"] ?? false,
        omitFromFinalGrade: json["omit_from_final_grade"] ?? false,
        intraGroupPeerReviews: json["intra_group_peer_reviews"] ?? false,
        anonymousInstructorAnnotations:
            json["anonymous_instructor_annotations"] ?? false,
        anonymousGrading: json["anonymous_grading"] ?? false,
        gradersAnonymousToGraders:
            json["graders_anonymous_to_graders"] ?? false,
        graderCount: json["grader_count"] ?? 0,
        graderCommentsVisibleToGraders:
            json["grader_comments_visible_to_graders"] ?? false,
        finalGraderId: json["final_grader_id"],
        graderNamesVisibleToFinalGrader:
            json["grader_names_visible_to_final_grader"] ?? false,
        allowedAttempts: json["allowed_attempts"] ?? 0,
        annotatableAttachmentId: json["annotatable_attachment_id"],
        secureParams: json["secure_params"] ?? '',
        ltiContextId: json["lti_context_id"] ?? '',
        courseId: json["course_id"] ?? 0,
        name: json["name"] ?? '',
        submissionTypes: null,
        hasSubmittedSubmissions: json["has_submitted_submissions"] ?? false,
        dueDateRequired: json["due_date_required"] ?? false,
        maxNameLength: json["max_name_length"],
        inClosedGradingPeriod: json["in_closed_grading_period"] ?? false,
        gradedSubmissionsExist: json["graded_submissions_exist"] ?? false,
        isQuizAssignment: json["is_quiz_assignment"] ?? false,
        canDuplicate: json["can_duplicate"] ?? false,
        originalCourseId: json["original_course_id"] == null
            ? null
            : json["original_course_id"],
        originalAssignmentId: json["original_assignment_id"] == null
            ? null
            : json["original_assignment_id"],
        originalLtiResourceLinkId: json["original_lti_resource_link_id"] == null
            ? null
            : json["original_lti_resource_link_id"],
        originalAssignmentName: json["original_assignment_name"] == null
            ? null
            : json["original_assignment_name"],
        originalQuizId: json["original_quiz_id"],
        workflowState: workflowStateValues.map[json["workflow_state"]],
        importantDates: json["important_dates"] ?? false,
        muted: json["muted"] ?? false,
        htmlUrl: json["html_url"],
        published: json["published"] ?? false,
        onlyVisibleToOverrides: json["only_visible_to_overrides"] ?? false,
        lockedForUser: json["locked_for_user"] ?? false,
        submissionsDownloadUrl: json["submissions_download_url"],
        postManually: json["post_manually"] ?? false,
        anonymizeStudents: json["anonymize_students"] ?? false,
        requireLockdownBrowser: json["require_lockdown_browser"] ?? false,
        lockInfo: json["lock_info"] == null
            ? null
            : LockInfo.fromJson(json["lock_info"]),
        lockExplanation:
            json["lock_explanation"] == null ? null : json["lock_explanation"],
        externalToolTagAttributes: json["external_tool_tag_attributes"] == null
            ? null
            : ExternalToolTagAttributes.fromJson(
                json["external_tool_tag_attributes"]),
        url: json["url"],
        isQuizLtiAssignment: json["is_quiz_lti_assignment"] == null
            ? null
            : json["is_quiz_lti_assignment"],
        frozenAttributes: json["frozen_attributes"] == null
            ? null
            : List<String>.from(json["frozen_attributes"].map((x) => x)),
      );
}

class ExternalToolTagAttributes {
  ExternalToolTagAttributes({
    required this.url,
    required this.newTab,
    required this.resourceLinkId,
    required this.externalData,
    required this.contentType,
    required this.contentId,
    required this.customParams,
  });

  String? url;
  bool? newTab;
  String? resourceLinkId;
  String? externalData;
  String? contentType;
  num? contentId;
  dynamic customParams;

  factory ExternalToolTagAttributes.fromJson(Map<String, dynamic> json) =>
      ExternalToolTagAttributes(
        url: json["url"],
        newTab: json["new_tab"],
        resourceLinkId: json["resource_link_id"],
        externalData: json["external_data"],
        contentType: json["content_type"],
        contentId: json["content_id"],
        customParams: json["custom_params"],
      );
}

enum GradingType { POINTS }

final gradingTypeValues = EnumValues({"points": GradingType.POINTS});

class LockInfo {
  LockInfo({
    required this.unlockAt,
    required this.assetString,
  });

  DateTime? unlockAt;
  String? assetString;

  factory LockInfo.fromJson(Map<String, dynamic> json) => LockInfo(
        unlockAt: DateTime.parse(json["unlock_at"]),
        assetString: json["asset_string"],
      );
}

enum SubmissionType { ON_PAPER, EXTERNAL_TOOL, ONLINE_UPLOAD }

final submissionTypeValues = EnumValues({
  "external_tool": SubmissionType.EXTERNAL_TOOL,
  "online_upload": SubmissionType.ONLINE_UPLOAD,
  "on_paper": SubmissionType.ON_PAPER
});

enum WorkflowState { PUBLISHED }

final workflowStateValues = EnumValues({"published": WorkflowState.PUBLISHED});

enum Type { ASSIGNMENT }

final typeValues = EnumValues({"assignment": Type.ASSIGNMENT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap ?? {};
  }
}
