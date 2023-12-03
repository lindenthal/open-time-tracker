import 'package:open_project_time_tracker/app/model/non_working_day.dart';
import 'package:open_project_time_tracker/app/model/week_day.dart';

abstract class WorkScheduleRepository {
  //TODO: add pagination
  Future<List<NonWorkingDay>> nonWorkingDays();

  Future<List<WeekDay>> weekDays();
}