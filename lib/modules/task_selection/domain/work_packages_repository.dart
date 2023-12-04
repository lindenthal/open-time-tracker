import '../../../app/model/work_package_form.dart';

abstract class WorkPackagesRepository {
  Future<List<WorkPackage>> list({
    int? userId,
    int? pageSize,
  });

  Future<void> createWorkPackage({
    required WorkPackageForm workPackage
  });
}

class WorkPackage {
  int id;
  String subject;
  String href;
  String projectTitle;
  String projectHref;
  String priority;
  String status;

  WorkPackage({
    required this.id,
    required this.subject,
    required this.href,
    required this.projectTitle,
    required this.projectHref,
    required this.priority,
    required this.status,
  });
}
