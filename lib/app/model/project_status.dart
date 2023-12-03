import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_status.g.dart';

@JsonSerializable()
class ProjectStatus {

  ProjectStatus({
    this.type,
    this.id,
    this.name,
  });

  @JsonKey(name: '_type')
  String? type;
  String? id;
  String? name;

  factory ProjectStatus.fromJson(Map<String, dynamic> json) =>
      _$ProjectStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectStatusToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}