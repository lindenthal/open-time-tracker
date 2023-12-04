import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_priority.g.dart';

@JsonSerializable()
class ProjectPriority {
  ProjectPriority({
    this.type,
    this.id,
    this.name,
    this.position,
    this.isDefault,
    this.isActive,
  });

  @JsonKey(name: '_type')
  String? type;
  int? id;
  String? name;
  int? position;
  bool? isDefault;
  bool? isActive;

  factory ProjectPriority.fromJson(Map<String, dynamic> json) => _$ProjectPriorityFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectPriorityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
