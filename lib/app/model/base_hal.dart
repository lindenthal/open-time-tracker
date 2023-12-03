
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_hal.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasHal<E> {

  BasHal({
    this.type,
    this.embedded,
  });


  @JsonKey(name: '_type')
  String? type;

  @JsonKey(name: '_embedded')
  E? embedded;

  // @JsonKey(name: '_links')
  // L? links;

  factory BasHal.fromJson(
      Map<String, dynamic> json,
      E Function(Object? json) fromJsonE,
      ) => _$BasHalFromJson(json, fromJsonE);

  Map<String, dynamic> toJson(Object Function(E value) toJsonE) =>
      _$BasHalToJson(this, toJsonE);

}