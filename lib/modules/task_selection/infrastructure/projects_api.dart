import 'package:dio/dio.dart';
import 'package:open_project_time_tracker/app/model/project_category.dart';
import 'package:open_project_time_tracker/app/model/project_priority.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';
import 'package:open_project_time_tracker/app/model/project_version.dart';
import 'package:retrofit/retrofit.dart';

import '../../../app/model/project.dart';

part 'projects_api.g.dart';

@RestApi()
abstract class ProjectsApi {
  factory ProjectsApi(Dio dio) = _ProjectsApi;

  @GET('/projects')
  Future<ProjectListResponse> projects();

  @GET('/projects/{id}/types')
  Future<ProjectTypesResponse> projectsTypes(@Path('id') String id);

  @GET('/versions')
  Future<ProjectVersionsResponse> projectVersions();

  @GET('/priorities')
  Future<ProjectPrioritiesResponse> projectPriorities();

  @GET('/projects/{id}/categories')
  Future<ProjectCategoriesResponse> projectCategories(@Path('id') String id);
}

class ProjectCategoriesResponse {
  late List<ProjectCategory> projectCategories;

  ProjectCategoriesResponse.fromJson(Map<String, dynamic> json) {
    List<ProjectCategory> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(ProjectCategory.fromJson(element));
    }
    projectCategories = items;
  }
}

class ProjectVersionsResponse {
  late List<ProjectVersion> projectVersions;

  ProjectVersionsResponse.fromJson(Map<String, dynamic> json) {
    List<ProjectVersion> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(ProjectVersion.fromJson(element));
    }
    projectVersions = items;
  }
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

class ProjectPrioritiesResponse {
  late List<ProjectPriority> projectPriorities;

  ProjectPrioritiesResponse.fromJson(Map<String, dynamic> json) {
    List<ProjectPriority> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(ProjectPriority.fromJson(element));
    }
    projectPriorities = items;
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
