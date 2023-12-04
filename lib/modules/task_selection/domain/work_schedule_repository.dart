import '../../../app/model/day.dart';
import '../../../app/model/non_working_day.dart';
import '../../../app/model/week_day.dart';

abstract class WorkScheduleRepository {
  //TODO: add pagination
  Future<List<NonWorkingDay>> nonWorkingDays();

  Future<List<WeekDay>> weekDays();

  //TODO: add pagination
  Future<List<Day>> upcomingDays();
}
