import 'package:freezed_annotation/freezed_annotation.dart';

part 'day.g.dart';

@JsonSerializable()
class Day {

  Day({this.type,
    this.name,
    this.date,
    this.working,
  });

  @JsonKey(name: '_type')
  String? type;
  String? name;
  bool? working;
  DateTime? date;

  factory Day.fromJson(Map<String, dynamic> json) =>
      _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}



