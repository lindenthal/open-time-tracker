
import 'package:freezed_annotation/freezed_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {

  Link({
    this.href,
    this.title,
    this.method,
    this.type,
  });

  String? href;

  String? title;

  LinkMethod? method;

  String? type;

  factory Link.fromJson(Map<String, dynamic> json) =>
      _$LinkFromJson(json);
}

enum LinkMethod {patch, post, get}



