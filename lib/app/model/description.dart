import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.g.dart';

@JsonSerializable()
class Description {

  Description({
    this.format = DescriptionFormat.markdown,
    this.raw = "",
    this.html = ""
  });

  DescriptionFormat? format;
  String? raw;
  String? html;

  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}

enum DescriptionFormat { plain, markdown, custom }