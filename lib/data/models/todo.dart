// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse required this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

class Todo {
  Todo({
    required this.contextType,
    required this.courseId,
    required this.contextName,
    required this.type,
    required this.ignore,
    required this.ignorePermanently,
    required this.assignment,
    required this.htmlUrl,
  });

  String contextType;
  int courseId;
  String contextName;
  String type;
  String ignore;
  String ignorePermanently;
  Assignment assignment;
  String htmlUrl;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        contextType: json["context_type"] ?? '',
        courseId: json["course_id"],
        contextName: json["context_name"] ?? '',
        type: json["type"] ?? '',
        ignore: json["ignore"] ?? '',
        ignorePermanently: json["ignore_permanently"] ?? '',
        assignment: Assignment.fromJson(json["assignment"]),
        htmlUrl: json["html_url"] ?? '',
      );

  // @override
  // String toString() {
  //   return 'Todo(contextType: $contextType, courseId: $courseId, contextName: $contextName, type: $type, ignore: $ignore, ignorePermanently: $ignorePermanently, assignment: $assignment, htmlUrl: $htmlUrl)';

  // }
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
    this.originalCourseId,
    required this.originalAssignmentId,
    required this.originalLtiResourceLinkId,
    required this.originalAssignmentName,
    required this.originalQuizId,
    required this.workflowState,
    required this.importantDates,
    required this.muted,
    required this.htmlUrl,
    required this.allDates,
    required this.published,
    required this.onlyVisibleToOverrides,
    required this.lockedForUser,
    required this.submissionsDownloadUrl,
    required this.postManually,
    required this.anonymizeStudents,
    required this.requireLockdownBrowser,
    required this.quizId,
    required this.anonymousSubmissions,
    required this.externalToolTagAttributes,
    required this.url,
  });

  num id;
  String description;
  DateTime dueAt;
  DateTime? unlockAt;
  DateTime? lockAt;
  num pointsPossible;
  String gradingType;
  num assignmentGroupId;
  dynamic gradingStandardId;
  DateTime createdAt;
  DateTime updatedAt;
  bool? peerReviews;
  bool? automaticPeerReviews;
  num position;
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
  num graderCount;
  bool? graderCommentsVisibleToGraders;
  dynamic finalGraderId;
  bool? graderNamesVisibleToFinalGrader;
  num allowedAttempts;
  dynamic annotatableAttachmentId;
  String secureParams;
  String ltiContextId;
  num courseId;
  String name;
  List<String> submissionTypes;
  bool? hasSubmittedSubmissions;
  bool? dueDateRequired;
  num maxNameLength;
  bool? inClosedGradingPeriod;
  bool? gradedSubmissionsExist;
  bool? isQuizAssignment;
  bool? canDuplicate;
  num? originalCourseId;
  num? originalAssignmentId;
  dynamic originalLtiResourceLinkId;
  String? originalAssignmentName;
  dynamic originalQuizId;
  String workflowState;
  bool? importantDates;
  bool? muted;
  String htmlUrl;
  List<AllDate> allDates;
  bool? published;
  bool? onlyVisibleToOverrides;
  bool? lockedForUser;
  String submissionsDownloadUrl;
  bool? postManually;
  bool? anonymizeStudents;
  bool requireLockdownBrowser;
  num? quizId;
  bool? anonymousSubmissions;
  ExternalToolTagAttributes? externalToolTagAttributes;
  dynamic url;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        description: json["description"] ?? '',
        dueAt: DateTime.parse(json["due_at"]),
        unlockAt: json["unlock_at"] == null
            ? null
            : DateTime.parse(json["unlock_at"]),
        lockAt:
            json["lock_at"] == null ? null : DateTime.parse(json["lock_at"]),
        pointsPossible: json["points_possible"],
        gradingType: json["grading_type"] ?? '',
        assignmentGroupId: json["assignment_group_id"],
        gradingStandardId: json["grading_standard_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        peerReviews: json["peer_reviews"],
        automaticPeerReviews: json["automatic_peer_reviews"],
        position: json["position"],
        gradeGroupStudentsIndividually:
            json["grade_group_students_individually"],
        anonymousPeerReviews: json["anonymous_peer_reviews"],
        groupCategoryId: json["group_category_id"],
        postToSis: json["post_to_sis"],
        moderatedGrading: json["moderated_grading"],
        omitFromFinalGrade: json["omit_from_final_grade"],
        intraGroupPeerReviews: json["intra_group_peer_reviews"],
        anonymousInstructorAnnotations:
            json["anonymous_instructor_annotations"],
        anonymousGrading: json["anonymous_grading"],
        gradersAnonymousToGraders: json["graders_anonymous_to_graders"],
        graderCount: json["grader_count"],
        graderCommentsVisibleToGraders:
            json["grader_comments_visible_to_graders"],
        finalGraderId: json["final_grader_id"],
        graderNamesVisibleToFinalGrader:
            json["grader_names_visible_to_final_grader"],
        allowedAttempts: json["allowed_attempts"],
        annotatableAttachmentId: json["annotatable_attachment_id"],
        secureParams: json["secure_params"] ?? '',
        ltiContextId: json["lti_context_id"] ?? '',
        courseId: json["course_id"],
        name: json["name"] ?? '',
        submissionTypes:
            List<String>.from(json["submission_types"].map((x) => x)),
        hasSubmittedSubmissions: json["has_submitted_submissions"],
        dueDateRequired: json["due_date_required"],
        maxNameLength: json["max_name_length"],
        inClosedGradingPeriod: json["in_closed_grading_period"],
        gradedSubmissionsExist: json["graded_submissions_exist"],
        isQuizAssignment: json["is_quiz_assignment"],
        canDuplicate: json["can_duplicate"],
        originalCourseId: json["original_course_id"] == null
            ? null
            : json["original_course_id"],
        originalAssignmentId: json["original_assignment_id"] == null
            ? null
            : json["original_assignment_id"],
        originalLtiResourceLinkId: json["original_lti_resource_link_id"],
        originalAssignmentName: json["original_assignment_name"] == null
            ? null
            : json["original_assignment_name"],
        originalQuizId: json["original_quiz_id"],
        workflowState: json["workflow_state"],
        importantDates: json["important_dates"],
        muted: json["muted"],
        htmlUrl: json["html_url"] ?? '',
        allDates: List<AllDate>.from(
            json["all_dates"].map((x) => AllDate.fromJson(x))),
        published: json["published"],
        onlyVisibleToOverrides: json["only_visible_to_overrides"],
        lockedForUser: json["locked_for_user"],
        submissionsDownloadUrl: json["submissions_download_url"] ?? '',
        postManually: json["post_manually"],
        anonymizeStudents: json["anonymize_students"],
        requireLockdownBrowser: json["require_lockdown_browser"],
        quizId: json["quiz_id"] == null ? null : json["quiz_id"],
        anonymousSubmissions: json["anonymous_submissions"] == null
            ? null
            : json["anonymous_submissions"],
        externalToolTagAttributes: json["external_tool_tag_attributes"] == null
            ? null
            : ExternalToolTagAttributes.fromJson(
                json["external_tool_tag_attributes"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "due_at": dueAt.toIso8601String(),
        "unlock_at": unlockAt == null ? null : unlockAt!.toIso8601String(),
        "lock_at": lockAt == null ? null : lockAt!.toIso8601String(),
        "points_possible": pointsPossible,
        "grading_type": gradingType,
        "assignment_group_id": assignmentGroupId,
        "grading_standard_id": gradingStandardId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "peer_reviews": peerReviews,
        "automatic_peer_reviews": automaticPeerReviews,
        "position": position,
        "grade_group_students_individually": gradeGroupStudentsIndividually,
        "anonymous_peer_reviews": anonymousPeerReviews,
        "group_category_id": groupCategoryId,
        "post_to_sis": postToSis,
        "moderated_grading": moderatedGrading,
        "omit_from_final_grade": omitFromFinalGrade,
        "intra_group_peer_reviews": intraGroupPeerReviews,
        "anonymous_instructor_annotations": anonymousInstructorAnnotations,
        "anonymous_grading": anonymousGrading,
        "graders_anonymous_to_graders": gradersAnonymousToGraders,
        "grader_count": graderCount,
        "grader_comments_visible_to_graders": graderCommentsVisibleToGraders,
        "final_grader_id": finalGraderId,
        "grader_names_visible_to_final_grader": graderNamesVisibleToFinalGrader,
        "allowed_attempts": allowedAttempts,
        "annotatable_attachment_id": annotatableAttachmentId,
        "secure_params": secureParams,
        "lti_context_id": ltiContextId,
        "course_id": courseId,
        "name": name,
        "submission_types": List<dynamic>.from(submissionTypes.map((x) => x)),
        "has_submitted_submissions": hasSubmittedSubmissions,
        "due_date_required": dueDateRequired,
        "max_name_length": maxNameLength,
        "in_closed_grading_period": inClosedGradingPeriod,
        "graded_submissions_exist": gradedSubmissionsExist,
        "is_quiz_assignment": isQuizAssignment,
        "can_duplicate": canDuplicate,
        "original_course_id":
            originalCourseId == null ? null : originalCourseId,
        "original_assignment_id":
            originalAssignmentId == null ? null : originalAssignmentId,
        "original_lti_resource_link_id": originalLtiResourceLinkId,
        "original_assignment_name":
            originalAssignmentName == null ? null : originalAssignmentName,
        "original_quiz_id": originalQuizId,
        "workflow_state": workflowState,
        "important_dates": importantDates,
        "muted": muted,
        "html_url": htmlUrl,
        "all_dates": List<dynamic>.from(allDates.map((x) => x.toJson())),
        "published": published,
        "only_visible_to_overrides": onlyVisibleToOverrides,
        "locked_for_user": lockedForUser,
        "submissions_download_url": submissionsDownloadUrl,
        "post_manually": postManually,
        "anonymize_students": anonymizeStudents,
        "require_lockdown_browser": requireLockdownBrowser,
        "quiz_id": quizId == null ? null : quizId,
        "anonymous_submissions":
            anonymousSubmissions == null ? null : anonymousSubmissions,
        "external_tool_tag_attributes": externalToolTagAttributes == null
            ? null
            : externalToolTagAttributes!.toJson(),
        "url": url,
      };

  @override
  String toString() {
    return 'Assignment(id: $id, description: $description, dueAt: $dueAt, unlockAt: $unlockAt, lockAt: $lockAt, pointsPossible: $pointsPossible, gradingType: $gradingType, assignmentGroupId: $assignmentGroupId, gradingStandardId: $gradingStandardId, createdAt: $createdAt, updatedAt: $updatedAt, peerReviews: $peerReviews, automaticPeerReviews: $automaticPeerReviews, position: $position, gradeGroupStudentsIndividually: $gradeGroupStudentsIndividually, anonymousPeerReviews: $anonymousPeerReviews, groupCategoryId: $groupCategoryId, postToSis: $postToSis, moderatedGrading: $moderatedGrading, omitFromFinalGrade: $omitFromFinalGrade, intraGroupPeerReviews: $intraGroupPeerReviews, anonymousInstructorAnnotations: $anonymousInstructorAnnotations, anonymousGrading: $anonymousGrading, gradersAnonymousToGraders: $gradersAnonymousToGraders, graderCount: $graderCount, graderCommentsVisibleToGraders: $graderCommentsVisibleToGraders, finalGraderId: $finalGraderId, graderNamesVisibleToFinalGrader: $graderNamesVisibleToFinalGrader, allowedAttempts: $allowedAttempts, annotatableAttachmentId: $annotatableAttachmentId, secureParams: $secureParams, ltiContextId: $ltiContextId, courseId: $courseId, name: $name, submissionTypes: $submissionTypes, hasSubmittedSubmissions: $hasSubmittedSubmissions, dueDateRequired: $dueDateRequired, maxNameLength: $maxNameLength, inClosedGradingPeriod: $inClosedGradingPeriod, gradedSubmissionsExist: $gradedSubmissionsExist, isQuizAssignment: $isQuizAssignment, canDuplicate: $canDuplicate, originalCourseId: $originalCourseId, originalAssignmentId: $originalAssignmentId, originalLtiResourceLinkId: $originalLtiResourceLinkId, ?originalAssignmentName: \$?originalAssignmentName, originalQuizId: $originalQuizId, workflowState: $workflowState, importantDates: $importantDates, muted: $muted, htmlUrl: $htmlUrl, allDates: $allDates, published: $published, onlyVisibleToOverrides: $onlyVisibleToOverrides, lockedForUser: $lockedForUser, submissionsDownloadUrl: $submissionsDownloadUrl, postManually: $postManually, anonymizeStudents: $anonymizeStudents, requireLockdownBrowser: $requireLockdownBrowser, quizId: $quizId, anonymousSubmissions: $anonymousSubmissions, externalToolTagAttributes: $externalToolTagAttributes, url: $url)';
  }
}

class AllDate {
  AllDate({
    required this.dueAt,
    required this.unlockAt,
    required this.lockAt,
    required this.base,
  });

  DateTime dueAt;
  DateTime? unlockAt;
  DateTime? lockAt;
  bool? base;

  factory AllDate.fromJson(Map<String, dynamic> json) => AllDate(
        dueAt: DateTime.parse(json["due_at"]),
        unlockAt: json["unlock_at"] == null
            ? null
            : DateTime.parse(json["unlock_at"]),
        lockAt:
            json["lock_at"] == null ? null : DateTime.parse(json["lock_at"]),
        base: json["base"],
      );

  Map<String, dynamic> toJson() => {
        "due_at": dueAt.toIso8601String(),
        "unlock_at": unlockAt == null ? null : unlockAt!.toIso8601String(),
        "lock_at": lockAt == null ? null : lockAt!.toIso8601String(),
        "base": base,
      };

  @override
  String toString() {
    return 'AllDate(dueAt: $dueAt, unlockAt: $unlockAt, lockAt: $lockAt, base: $base)';
  }
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

  String url;
  bool? newTab;
  String resourceLinkId;
  String externalData;
  String contentType;
  num contentId;
  dynamic customParams;

  factory ExternalToolTagAttributes.fromJson(Map<String, dynamic> json) =>
      ExternalToolTagAttributes(
        url: json["url"] ?? '',
        newTab: json["new_tab"],
        resourceLinkId: json["resource_link_id"] ?? '',
        externalData: json["external_data"] ?? '',
        contentType: json["content_type"] ?? '',
        contentId: json["content_id"],
        customParams: json["custom_params"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "new_tab": newTab,
        "resource_link_id": resourceLinkId,
        "external_data": externalData,
        "content_type": contentType,
        "content_id": contentId,
        "custom_params": customParams,
      };

  @override
  String toString() {
    return 'ExternalToolTagAttributes(url: $url, newTab: $newTab, resourceLinkId: $resourceLinkId, externalData: $externalData, contentType: $contentType, contentId: $contentId, customParams: $customParams)';
  }
}
