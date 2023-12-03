import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_day.g.dart';

@JsonSerializable()
class WeekDay {

  WeekDay({this.type,
    this.day,
    this.working,
    this.title,
  });

  @JsonKey(name: '_type')
  String? type;
  int? day;
  bool? working;
  String? title;

  factory WeekDay.fromJson(Map<String, dynamic> json) =>
      _$WeekDayFromJson(json);

  Map<String, dynamic> toJson() => _$WeekDayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
