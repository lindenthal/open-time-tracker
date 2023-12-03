import 'package:open_project_time_tracker/app/model/project.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
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
}
