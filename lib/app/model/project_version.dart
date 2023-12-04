import 'package:freezed_annotation/freezed_annotation.dart';

import 'description.dart';

part 'project_version.g.dart';

@JsonSerializable()
class ProjectVersion {
  ProjectVersion({
    this.type,
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.sharing,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: '_type')
  String? type;
  int? id;
  String? name;

  @JsonKey(fromJson: descriptionFromJson, toJson: descriptionToJson)
  Description? description;
  DateTime? startDate;
  DateTime? endDate;
  String? sharing;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProjectVersion.fromJson(Map<String, dynamic> json) => _$ProjectVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectVersionToJson(this);

  static Description? descriptionFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Description.fromJson(json);
  }

  static Map<String, dynamic>? descriptionToJson(Description? description) {
    return description?.toJson();
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
