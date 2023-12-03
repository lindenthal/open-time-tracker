import 'package:freezed_annotation/freezed_annotation.dart';

part 'non_working_day.g.dart';

@JsonSerializable()
class NonWorkingDay {

  NonWorkingDay({
    required this.id,
    this.type,
    this.name,
    this.date,
  });

  double id;
  @JsonKey(name: '_type')
  String? type;
  String? name;
  DateTime? date;


  factory NonWorkingDay.fromJson(Map<String, dynamic> json) =>
      _$NonWorkingDayFromJson(json);

  Map<String, dynamic> toJson() => _$NonWorkingDayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
