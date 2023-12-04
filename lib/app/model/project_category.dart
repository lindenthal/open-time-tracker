import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_category.g.dart';

@JsonSerializable()
class ProjectCategory {
  ProjectCategory({
    this.type,
    this.id,
    this.name,
  });

  @JsonKey(name: '_type')
  String? type;
  int? id;
  String? name;

  factory ProjectCategory.fromJson(Map<String, dynamic> json) => _$ProjectCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectCategoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}
