import 'package:open_project_time_tracker/app/model/project_type.dart';

import '../../../app/model/project.dart';

abstract class ProjectsRepository {
  Future<List<Project>> list();
  Future<List<ProjectType>> typesList(String id);
}
