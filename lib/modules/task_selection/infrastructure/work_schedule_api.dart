import 'package:dio/dio.dart';
import 'package:open_project_time_tracker/app/model/non_working_day.dart';
import 'package:open_project_time_tracker/app/model/week_day.dart';
import 'package:retrofit/retrofit.dart';

part 'work_schedule_api.g.dart';

@RestApi()
abstract class WorkScheduleApi {
  factory WorkScheduleApi(Dio dio) = _WorkScheduleApi;

  @GET('/days/week')
  Future<WeekDaysListResponse> weekDays();

  @GET('/days/non_working')
  Future<NonWorkingDaysResponse> nonWorkingDays();
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
  late List<WeekDay> weekDay;

  WeekDaysListResponse.fromJson(Map<String, dynamic> json) {
    List<WeekDay> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(WeekDay.fromJson(element));
    }
    weekDay = items;
  }
}