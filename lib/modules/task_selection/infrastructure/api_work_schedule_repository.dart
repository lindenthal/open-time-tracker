import 'package:open_project_time_tracker/app/model/non_working_day.dart';
import 'package:open_project_time_tracker/app/model/week_day.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_schedule_repository.dart';

import 'work_schedule_api.dart';

class ApiWorkScheduleRepository implements WorkScheduleRepository {
  WorkScheduleApi restApi;

  ApiWorkScheduleRepository(this.restApi);

  @override
  Future<List<NonWorkingDay>> nonWorkingDays() async {
    final response = await restApi.nonWorkingDays();
    return response.nonWorkingDays.map((e) => e).toList();
  }

  @override
  Future<List<WeekDay>> weekDays() async {
    final response = await restApi.weekDays();
    return response.weekDay.map((e) => e).toList();
  }
}
