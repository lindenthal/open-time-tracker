
import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.g.dart';

@JsonSerializable()
class Description {

  Description({
    this.format,
    this.raw,
    this.html,
  });

  DescriptionFormat? format;
  String? raw;
  String? html;

  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
}

enum DescriptionFormat {plain, markdown, custom}