import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_type.g.dart';

@JsonSerializable()
class ProjectType {
  ProjectType({
    this.type,
    required this.id,
    this.name,
    this.color,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.isDefault = false,
    this.isMilestone = false,
  });

  @JsonKey(name: '_type')
  String? type;
  int id;
  String? name;
  String? color;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isDefault;
  bool isMilestone;

  factory ProjectType.fromJson(Map<String, dynamic> json) => _$ProjectTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectTypeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
