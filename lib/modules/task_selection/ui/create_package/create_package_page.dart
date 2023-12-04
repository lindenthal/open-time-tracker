import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_project_time_tracker/app/model/description.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
import 'package:open_project_time_tracker/app/model/work_package_form.dart';
import 'package:open_project_time_tracker/app/ui/bloc/bloc_page.dart';
import 'package:open_project_time_tracker/app/ui/widgets/activity_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/create_package/widgets/calendar_widget.dart';
import 'package:open_project_time_tracker/modules/task_selection/ui/create_package/widgets/dropdown_widget.dart';

import 'create_package_bloc.dart';

class CreatePackagePage extends EffectBlocPage<CreatePackageBloc, CreatePackageState, CreatePackageEffect> {
  const CreatePackagePage({super.key});

  @override
  void onCreate(BuildContext context, CreatePackageBloc bloc) {
    super.onCreate(context, bloc);
    bloc.reload();
  }

  @override
  void onEffect(BuildContext context, CreatePackageEffect effect) {
    effect.when(
      complete: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      error: () {
        final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context).generic_error),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget buildState(BuildContext context, CreatePackageState state) {
    final Widget body = state.when(
      loading: () => const Center(child: ActivityIndicator()),
      update: (projectDetails, form) =>
          _updateWidget(context, projectDetails ?? PackageDetails(), form ?? WorkPackageForm()),
      idle: (projectDetails, form) =>
          _updateWidget(context, projectDetails ?? PackageDetails(), form ?? WorkPackageForm()),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).create_work_package_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: body,
      ),
    );
  }

  Widget _updateWidget(BuildContext context, PackageDetails projectDetails, WorkPackageForm workPackageForm) {
    log("_updateWidget ${workPackageForm.ignoreNonWorkingDays}");
    final titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45);
    CreatePackageBloc bloc = context.read<CreatePackageBloc>();

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    titleController.addListener(() {
      log("updateText title: ${titleController.text}");
    });
    final durationController = TextEditingController();
    durationController.value = durationController.value.copyWith(
      text: workPackageForm.duration?.toString() ?? "",
      selection: TextSelection.collapsed(offset: (workPackageForm.duration?.toString() ?? "").length),
    );
    durationController.text = workPackageForm.duration?.toString() ?? "";
    durationController.addListener(() {
      // if (durationController.text.isNotEmpty) {
      //   log("updateText ${durationController.text}");
      //   bloc.updateForm(updatedForm: workPackageForm.copyWith(duration: durationController.text,));
      // }
    });

    log("Projects: ${projectDetails.projects?.map((e) => e.name ?? "").toList() ?? []}");
    log("WeekDays: ${projectDetails.weekDays?.map((e) => e.working ?? "").toList() ?? []}");
    log("NonWorkingDays: ${projectDetails.nonWorkingDays?.map((e) => e.name ?? "").toList() ?? []}");
    log("ProjectTypes: ${projectDetails.projectTypes?.map((e) => e.name ?? "").toList() ?? []}");
    log("ProjectVersions: ${projectDetails.projectVersions?.map((e) => e.name ?? "").toList() ?? []}");
    log("ProjectCategories: ${projectDetails.projectCategories?.map((e) => e.name ?? "").toList() ?? []}");
    log("projectPriorities: ${projectDetails.projectPriorities?.map((e) => e.name ?? "").toList() ?? []}");

    final weekends =
        projectDetails.weekDays?.where((element) => element.working == false).map((e) => e.day ?? 0).toList();

    final nonWorkingDays = projectDetails.nonWorkingDays?.map((e) => e.date ?? DateTime(1970)).toList();

    return RefreshIndicator(
        onRefresh: () async {
          context.read<CreatePackageBloc>().reload();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Project subject", style: titleStyle),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter package title',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                Text("Project description", style: titleStyle),
                TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter package description',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownWidget(
                  title: "Project name",
                  itemsList: projectDetails.projects?.map((e) => e.name ?? "").toList() ?? [],
                  onItemClick: (item) => {},
                ),
                const SizedBox(height: 16),
                DropdownWidget(
                  title: "Package type",
                  itemsList: projectDetails.projectTypes?.map((e) => e.name ?? "").toList() ?? [],
                  onItemClick: (item) => {},
                ),
                const SizedBox(height: 16),
                DropdownWidget(
                  title: "Project version",
                  itemsList: projectDetails.projectVersions?.map((e) => e.name ?? "").toList() ?? [],
                  onItemClick: (item) => {},
                ),
                const SizedBox(height: 16),
                DropdownWidget(
                  title: "Project category",
                  itemsList: projectDetails.projectCategories?.map((e) => e.name ?? "").toList() ?? [],
                  onItemClick: (item) => {},
                ),
                const SizedBox(height: 16),
                DropdownWidget(
                  title: "Priority",
                  itemsList: projectDetails.projectPriorities?.map((e) => e.name ?? "").toList() ?? [],
                  onItemClick: (item) => {},
                ),
                const SizedBox(height: 32),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black45,
                ),
                const SizedBox(height: 16),
                Text("Start date", style: titleStyle),
                CalendarWidget(
                  isStart: true,
                  weekends: weekends,
                  nonWorkingDays: nonWorkingDays,
                  selectedDates: [workPackageForm.startDate, workPackageForm.dueDate],
                  onUpdateDates: (dates) => bloc.updateForm(
                      updatedForm: workPackageForm.copyWith(
                          startDate: dates?.first,
                          dueDate: dates?.last,
                          duration: ((dates?.last?.day ?? 1) - (dates?.first?.day ?? 0) + 1).toString())),
                ),
                const SizedBox(height: 16),
                Text("End data", style: titleStyle),
                CalendarWidget(
                  isStart: false,
                  weekends: weekends,
                  nonWorkingDays: nonWorkingDays,
                  selectedDates: [workPackageForm.startDate, workPackageForm.dueDate],
                  onUpdateDates: (dates) => bloc.updateForm(
                      updatedForm: workPackageForm.copyWith(startDate: dates?.first, dueDate: dates?.last)),
                ),
                const SizedBox(height: 16),
                Text("Duration", style: titleStyle),
                SizedBox(
                  child: TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter duration',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Ignore Non-working days',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.blue.shade100,
                      thumbColor: Colors.blue.shade700,
                      trackColor: Colors.black12,
                      value: workPackageForm.ignoreNonWorkingDays ?? false,
                      onChanged: (value) => {
                        bloc.updateForm(updatedForm: workPackageForm.copyWith(ignoreNonWorkingDays: value)),
                      },
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => {
                        bloc.updateForm(
                          updatedForm: workPackageForm.copyWith(
                            title: titleController.text,
                            description: Description(raw: descriptionController.text, format: DescriptionFormat.markdown, ),
                            projectType: ProjectType(id: 2, href: "${ProjectType.hrefPrefix}2")
                          ),
                        ),
                        bloc.submitForm()
                      },
                      child: Text("Submit"),
                    )),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ));
  }
}
