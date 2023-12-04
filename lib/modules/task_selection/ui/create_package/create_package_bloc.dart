import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_project_time_tracker/app/model/non_working_day.dart';
import 'package:open_project_time_tracker/app/model/project.dart';
import 'package:open_project_time_tracker/app/model/project_category.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
import 'package:open_project_time_tracker/app/model/project_version.dart';
import 'package:open_project_time_tracker/app/model/week_day.dart';
import 'package:open_project_time_tracker/app/model/work_package_form.dart';
import 'package:open_project_time_tracker/app/ui/bloc/bloc.dart';
import 'package:open_project_time_tracker/modules/authorization/domain/user_data_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/time_entries_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_packages_repository.dart';
import 'package:open_project_time_tracker/modules/task_selection/domain/work_schedule_repository.dart';
import 'package:open_project_time_tracker/modules/timer/domain/timer_repository.dart';

import '../../../../app/model/project_priority.dart';
import '../../domain/projects_repository.dart';

part 'create_package_bloc.freezed.dart';

@freezed
class CreatePackageState with _$CreatePackageState {
  const factory CreatePackageState.loading() = _Loading;

  const factory CreatePackageState.idle({
    required PackageDetails? packageDetails,
    required WorkPackageForm? form,
  }) = _Idle;

  const factory CreatePackageState.update({
    required PackageDetails? packageDetails,
    required WorkPackageForm? form,
  }) = _Update;
}

@freezed
class CreatePackageEffect with _$CreatePackageEffect {
  const factory CreatePackageEffect.complete() = _Complete;

  const factory CreatePackageEffect.error() = _Error;
}

class CreatePackageBloc extends EffectCubit<CreatePackageState, CreatePackageEffect> with WidgetsBindingObserver {
  final WorkPackagesRepository _workPackagesRepository;
  final UserDataRepository _userDataRepository;
  final TimerRepository _timerRepository;
  final ProjectsRepository _projectsRepository;
  final WorkScheduleRepository _workScheduleRepository;

  CreatePackageBloc(
    this._projectsRepository,
    this._workPackagesRepository,
    this._userDataRepository,
    this._timerRepository,
    this._workScheduleRepository,
  ) : super(const CreatePackageState.loading()) {
    WidgetsBinding.instance.addObserver(this);
  }

  WorkPackageForm? form;
  PackageDetails? packageDetails;

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

  Future<void> submitForm() async {
    try {
      form = form!.copyWith(duration:"P${form!.duration}D");
      log("submitForm ${form!.toString()}");

      await _workPackagesRepository.createWorkPackage(workPackage: form!);
    } catch (e) {
      emitEffect(const CreatePackageEffect.error());
    }
  }
  Future<void> updateForm({WorkPackageForm? updatedForm}) async {
    try {
      form = updatedForm;
      emit(CreatePackageState.update(packageDetails: packageDetails, form: form?.copyWith()));
    } catch (e) {
      emitEffect(const CreatePackageEffect.error());
    }
  }

  Future<void> reload({
    bool showLoading = false,
  }) async {
    try {
      if (showLoading) {
        emit(const CreatePackageState.loading());
      }

      final projects = await _projectsRepository.list();
      final weekDays = await _workScheduleRepository.weekDays();
      final nonWorkingDays = await _workScheduleRepository.nonWorkingDays();
      final projectTypes = await _projectsRepository.typesList("1");
      final projectCategories = await _projectsRepository.categoriesList("1");
      final projectPriorities = await _projectsRepository.prioritiesList("1");
      final projectVersions = await _projectsRepository.versionsList("1");

      form = WorkPackageForm();

      packageDetails = PackageDetails(
          projects: projects,
          weekDays: weekDays,
          nonWorkingDays: nonWorkingDays,
          projectTypes: projectTypes,
          projectVersions: projectVersions,
          projectCategories: projectCategories,
          projectPriorities: projectPriorities);

      emit(CreatePackageState.idle(packageDetails: packageDetails, form: form));
    } catch (e) {
      emit(CreatePackageState.idle(
        packageDetails: PackageDetails(),
        form: form
      ));
      emitEffect(const CreatePackageEffect.error());
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
      emitEffect(const CreatePackageEffect.complete());
    } catch (e) {
      emitEffect(const CreatePackageEffect.error());
    }
  }
}

class PackageDetails {
  PackageDetails({
    this.projects,
    this.weekDays,
    this.nonWorkingDays,
    this.projectTypes,
    this.projectVersions,
    this.projectCategories,
    this.projectPriorities,
  });

  final List<Project>? projects;
  final List<WeekDay>? weekDays;
  final List<NonWorkingDay>? nonWorkingDays;
  final List<ProjectType>? projectTypes;
  final List<ProjectVersion>? projectVersions;
  final List<ProjectCategory>? projectCategories;
  final List<ProjectPriority>? projectPriorities;
}
