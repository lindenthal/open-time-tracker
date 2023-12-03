import 'package:freezed_annotation/freezed_annotation.dart';

import 'link.dart';

part 'projects_links.g.dart';


@JsonSerializable()
class ProjectLinks {
  ProjectLinks({
    this.self,
  });

  Link? self;

  factory ProjectLinks.fromJson(Map<String, dynamic> json) =>
      _$ProjectLinksFromJson(json);
}
