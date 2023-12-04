import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import '../../../app/model/day.dart';
import '../../../app/model/non_working_day.dart';
import '../../../app/model/week_day.dart';

part 'work_schedule_api.g.dart';

@RestApi()
abstract class WorkScheduleApi {
  factory WorkScheduleApi(Dio dio) = _WorkScheduleApi;

  @GET('/days/week')
  Future<WeekDaysListResponse> weekDays();

  @GET('/days/non_working')
  Future<NonWorkingDaysResponse> nonWorkingDays();

  @GET('/days')
  Future<DaysListResponse> days();
}

class NonWorkingDaysResponse {
  late List<NonWorkingDay> nonWorkingDays;

  NonWorkingDaysResponse.fromJson(Map<String, dynamic> json) {
    List<NonWorkingDay> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(NonWorkingDay.fromJson(element));
    }
    nonWorkingDays = items;
  }
}

class WeekDaysListResponse {
  late List<WeekDay> weekDays;

  WeekDaysListResponse.fromJson(Map<String, dynamic> json) {
    List<WeekDay> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(WeekDay.fromJson(element));
    }
    weekDays = items;
  }
}

class DaysListResponse {
  late List<Day> upcomingDays;

  DaysListResponse.fromJson(Map<String, dynamic> json) {
    List<Day> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(Day.fromJson(element));
    }
    upcomingDays = items;
  }
}