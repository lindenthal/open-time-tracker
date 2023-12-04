import 'package:freezed_annotation/freezed_annotation.dart';

import 'description.dart';
import 'project_type.dart';

part 'work_package_form.g.dart';

@JsonSerializable()
class WorkPackageForm {
  WorkPackageForm({
    this.description,
    this.projectType,
    this.working,
    this.title,
    this.scheduleManually = false,
    this.startDate,
    this.dueDate,
    this.ignoreNonWorkingDays = false,
    this.percentageDone = 0,
    this.estimatedTime,
    this.duration,
  });

  @JsonKey(fromJson: descriptionFromJson, toJson: descriptionToJson)
  Description? description;

  @JsonKey(name: 'type', fromJson: projectTypeFromJson, toJson: projectTypeToJson)
  ProjectType? projectType;

  bool? working;

  @JsonKey(name: 'subject')
  String? title;
  bool scheduleManually;
  DateTime? startDate;
  DateTime? dueDate;
  bool? ignoreNonWorkingDays;
  int? percentageDone;
  String? estimatedTime;
  String? duration;

  factory WorkPackageForm.fromJson(Map<String, dynamic> json) => _$WorkPackageFormFromJson(json);

  Map<String, dynamic> toJson() => _$WorkPackageFormToJson(this);

  static Description? descriptionFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Description.fromJson(json);
  }

  static Map<String, dynamic>? descriptionToJson(Description? description) {
    return description?.toJson();
  }

  static ProjectType? projectTypeFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return ProjectType.fromJson(json);
  }

  static Map<String, dynamic>? projectTypeToJson(ProjectType? projectType) {
    return projectType?.toJson();
  }

  @override
  String toString() {
    return toJson().toString();
  }

  WorkPackageForm copyWith({
    Description? description,
    ProjectType? projectType,
    bool? working,
    String? title,
    bool? scheduleManually,
    DateTime? startDate,
    DateTime? dueDate,
    bool? ignoreNonWorkingDays,
    int? percentageDone,
    String? estimatedTime,
    String? duration,
  }) {
    return WorkPackageForm(
        description: description ?? this.description,
        projectType: projectType ?? this.projectType,
        working: working ?? this.working,
        title: title ?? this.title,
        scheduleManually: scheduleManually ?? this.scheduleManually,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate,
        ignoreNonWorkingDays: ignoreNonWorkingDays ?? this.ignoreNonWorkingDays,
        percentageDone: percentageDone ?? this.percentageDone,
        estimatedTime: estimatedTime ?? this.estimatedTime,
        duration: duration ?? this.duration);
  }
}
