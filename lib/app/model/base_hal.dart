
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_hal.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseHal<E> {

  BaseHal({
    this.type,
    this.embedded,
  });


  @JsonKey(name: '_type')
  String? type;

  @JsonKey(name: '_embedded')
  E? embedded;

  // @JsonKey(name: '_links')
  // L? links;

  factory BaseHal.fromJson(
      Map<String, dynamic> json,
      E Function(Object? json) fromJsonE,
      ) => _$BaseHalFromJson(json, fromJsonE);

  Map<String, dynamic> toJson(Object Function(E value) toJsonE) =>
      _$BaseHalToJson(this, toJsonE);

}