import 'package:injectable/injectable.dart';
import 'package:open_project_time_tracker/app/auth/domain/auth_service.dart';
import 'package:open_project_time_tracker/app/storage/preferences_storage.dart';
import 'package:open_project_time_tracker/modules/authorization/domain/user_data_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/projects_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/settings_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/time_entries_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_packages_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_schedule_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/api_projects_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/api_time_entries_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/api_work_packages_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/api_work_schedule_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/local_settings_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/projects_api.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/time_entries_api.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/work_packages_api.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/work_schedule_api.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/analytics/analytics_bloc.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/notification_selection_list/notification_selection_list_bloc.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/time_entries_list/time_entries_list_bloc.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/work_packages_list/work_packages_list_bloc.dart';
import 'package:open_project_time_tracker/modules/timer/domain/timer_repository.dart';

import '../../app/api/api_client.dart';
import '../calendar/domain/calendar_notifications_service.dart';

@module
abstract class TaskSelectionModule {
  @lazySingleton
  TimeEntriesApi timeEntriesApi(
    @Named('openProject') ApiClient client,
  ) =>
      TimeEntriesApi(
        client.dio,
      );

  @lazySingleton
  WorkPackagesApi workPackagesApi(
    @Named('openProject') ApiClient client,
  ) =>
      WorkPackagesApi(
        client.dio,
      );

  @lazySingleton
  ProjectsApi projectsApi(
    @Named('openProject') ApiClient client,
  ) =>
      ProjectsApi(
        client.dio,
      );

  @lazySingleton
  WorkScheduleApi workScheduleApi(
    @Named('openProject') ApiClient client,
  ) =>
      WorkScheduleApi(
        client.dio,
      );

  @lazySingleton
  TimeEntriesRepository timeEntriesRepository(
    TimeEntriesApi timeEntriesApi,
  ) =>
      ApiTimeEntriesRepository(
        timeEntriesApi,
      );

  @lazySingleton
  WorkPackagesRepository workPackagesRepository(
    WorkPackagesApi workPackagesApi,
  ) =>
      ApiWorkPackagesRepository(
        workPackagesApi,
      );

  @lazySingleton
  ProjectsRepository projectsRepository(
    ProjectsApi projectsApi,
  ) =>
      ApiProjectsRepository(
        projectsApi,
      );

  @lazySingleton
  WorkScheduleRepository workScheduleRepository(
    WorkScheduleApi workScheduleApi,
  ) =>
      ApiWorkScheduleRepository(
        workScheduleApi,
      );

  @lazySingleton
  SettingsRepository settingsRepository() => LocalSettingsRepository(
        PreferencesStorage(),
      );

  @injectable
  TimeEntriesListBloc timeEntriesListBloc(
    TimeEntriesRepository timeEntriesRepository,
    UserDataRepository userDataRepository,
    SettingsRepository settingsRepository,
    @Named('openProject') AuthService authService,
    @Named('graph') AuthService graphAuthService,
    TimerRepository timerRepository,
    CalendarNotificationsService calendarNotificationsService,
  ) =>
      TimeEntriesListBloc(
        timeEntriesRepository,
        userDataRepository,
        settingsRepository,
        authService,
        graphAuthService,
        timerRepository,
        calendarNotificationsService,
      );

  @injectable
  WorkPackagesListBloc workPackagesListBloc(
    ProjectsRepository projectsRepository,
    WorkPackagesRepository workPackagesRepository,
    UserDataRepository userDataRepository,
    TimerRepository timerRepository,
    WorkScheduleRepository workScheduleRepository,
  ) =>
      WorkPackagesListBloc(
        projectsRepository,
        workPackagesRepository,
        userDataRepository,
        timerRepository,
        workScheduleRepository,
      );

  @injectable
  AnalyticsBloc analyticsBloc(
    TimeEntriesRepository timeEntriesRepository,
    UserDataRepository userDataRepository,
  ) =>
      AnalyticsBloc(
        timeEntriesRepository,
        userDataRepository,
      );

  @injectable
  NotificationSelectionListBloc notificationSelectionListBloc(
    WorkPackagesRepository workPackagesRepository,
    UserDataRepository userDataRepository,
    TimerRepository timerRepository,
    TimeEntriesRepository timeEntriesRepository,
  ) =>
      NotificationSelectionListBloc(
        workPackagesRepository,
        userDataRepository,
        timerRepository,
        timeEntriesRepository,
      );
}
