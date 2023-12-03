import 'package:dio/dio.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
import 'package:retrofit/retrofit.dart';

import '../../../app/model/project.dart';

part 'projects_api.g.dart';

@RestApi()
abstract class ProjectsApi {
  factory ProjectsApi(Dio dio) = _ProjectsApi;

  @GET('/projects')
  Future<ProjectListResponse> projects();

  @GET('projects/{id}/types')
  Future<ProjectTypesResponse> projectsTypes(@Path('id') String id);

// @POST('/work_packages/form')
}

class ProjectTypesResponse {
  late List<ProjectType> projectTypes;

  ProjectTypesResponse.fromJson(Map<String, dynamic> json) {
    List<ProjectType> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(ProjectType.fromJson(element));
    }
    projectTypes = items;
  }
}

class ProjectListResponse {
  late List<Project> projects;

  ProjectListResponse.fromJson(Map<String, dynamic> json) {
    List<Project> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(Project.fromJson(element));
    }
    projects = items;
  }
}
