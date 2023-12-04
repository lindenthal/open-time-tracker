import 'package:open_project_time_tracker/app/model/project_priority.dart';
import 'package:open_project_time_tracker/app/model/project_type.dart';

import '../../../app/model/project.dart';
import '../../../app/model/project_category.dart';
import '../../../app/model/project_version.dart';

abstract class ProjectsRepository {
  Future<List<Project>> list();
  Future<List<ProjectType>> typesList(String id);
  Future<List<ProjectVersion>> versionsList(String id);
  Future<List<ProjectCategory>> categoriesList(String id);
  Future<List<ProjectPriority>> prioritiesList(String id);
}
