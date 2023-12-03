import 'package:freezed_annotation/freezed_annotation.dart';

import 'description.dart';
import 'projects_links.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  Project({
    this.id,
    this.name,
    this.identifier,
    this.active,
    this.status,
    this.statusExplanation,
    this.public,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.links,
  });

  int? id;

  String? name;

  String? identifier;

  bool? active;

  ProjectStatus? status;

  Description? statusExplanation;

  bool? public;

  Description? description;

  DateTime? createdAt;
  DateTime? updatedAt;

  ProjectLinks? links;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProjectStatus { on_track, at_risk, off_track }
