import 'package:open_project_time_tracker/app/model/project.dart';
import 'package:open_project_time_tracker/app/model/project_category.dart';
import 'package:open_project_time_tracker/app/model/project_priority.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
import 'package:open_project_time_tracker/app/model/project_version.dart';
import 'package:open_project_time_tracker/modules/task_selection/infrastructure/projects_api.dart';

import '../domain/projects_repository.dart';

class ApiProjectsRepository implements ProjectsRepository {
  ProjectsApi restApi;

  ApiProjectsRepository(this.restApi);

  @override
  Future<List<Project>> list() async {
    final response = await restApi.projects();
    return response.projects.map((e) => e).toList();
  }

  @override
  Future<List<ProjectType>> typesList(String id) async {
    final response = await restApi.projectsTypes(id);
    return response.projectTypes.map((e) => e).toList();
  }

  @override
  Future<List<ProjectCategory>> categoriesList(String id) async {
    final response = await restApi.projectCategories(id);
    return response.projectCategories.map((e) => e).toList();
  }

  @override
  Future<List<ProjectVersion>> versionsList(String id) async {
    final response = await restApi.projectVersions();
    return response.projectVersions.map((e) => e).toList();
  }

  @override
  Future<List<ProjectPriority>> prioritiesList(String id) async {
    final response = await restApi.projectPriorities();
    return response.projectPriorities.map((e) => e).toList();
  }
}
