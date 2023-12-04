import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_project_time_tracker/app/ui/bloc/bloc.dart';
import 'package:open_project_time_tracker/modules/authorization/domain/user_data_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/time_entries_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_packages_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_schedule_repository.dart';
import 'package:open_project_time_tracker/modules/timer/domain/timer_repository.dart';

import '../../domain/projects_repository.dart';

part 'work_packages_list_bloc.freezed.dart';

@freezed
class WorkPackagesListState with _$WorkPackagesListState {
  const factory WorkPackagesListState.loading() = _Loading;

  const factory WorkPackagesListState.idle({
    required List<WorkPackage> workPackages,
  }) = _Idle;
}

@freezed
class WorkPackagesListEffect with _$WorkPackagesListEffect {
  const factory WorkPackagesListEffect.complete() = _Complete;

  const factory WorkPackagesListEffect.error() = _Error;
}

class WorkPackagesListBloc extends EffectCubit<WorkPackagesListState, WorkPackagesListEffect>
    with WidgetsBindingObserver {
  final WorkPackagesRepository _workPackagesRepository;
  final UserDataRepository _userDataRepository;
  final TimerRepository _timerRepository;
  final ProjectsRepository _projectsRepository;
  final WorkScheduleRepository _workScheduleRepository;

  WorkPackagesListBloc(
    this._projectsRepository,
    this._workPackagesRepository,
    this._userDataRepository,
    this._timerRepository,
    this._workScheduleRepository,
  ) : super(const WorkPackagesListState.loading()) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      reload(showLoading: true);
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> reload({
    bool showLoading = false,
  }) async {
    try {
      if (showLoading) {
        emit(const WorkPackagesListState.loading());
      }

      final items = await _workPackagesRepository.list(
        userId: _userDataRepository.userID,
        pageSize: 100,
      );
      emit(WorkPackagesListState.idle(
        workPackages: items,
      ));
    } catch (e) {
      emit(const WorkPackagesListState.idle(
        workPackages: [],
      ));
      emitEffect(const WorkPackagesListEffect.error());
    }
  }

  Future<void> setTimeEntry(
    WorkPackage workPackage,
  ) async {
    try {
      final timeEntry = TimeEntry.fromWorkPackage(workPackage);
      await _timerRepository.setTimeEntry(
        timeEntry: timeEntry,
      );
      emitEffect(const WorkPackagesListEffect.complete());
    } catch (e) {
      emitEffect(const WorkPackagesListEffect.error());
    }
  }
}
