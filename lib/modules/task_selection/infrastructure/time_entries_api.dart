import 'package:dio/dio.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'time_entries_api.g.dart';

@RestApi()
abstract class TimeEntriesApi {
  factory TimeEntriesApi(Dio dio) = _TimeEntriesApi;

  @GET('/time_entries')
  Future<TimeEntriesResponse> timeEntries({
    @Query('filters') String? filters,
  });
}

class TimeEntryResponse {
  late int? id;
  late String workPackageSubject;
  late String workPackageHref;
  late String projectTitle;
  late String projectHref;
  late Duration hours;
  late String? comment;

  TimeEntryResponse({
    required this.id,
    required this.workPackageSubject,
    required this.workPackageHref,
    required this.projectTitle,
    required this.projectHref,
    required this.hours,
    this.comment,
  });

  TimeEntryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    final commentJson = json["comment"];
    comment = commentJson["raw"];

    final links = json["_links"];
    final project = links["project"];
    projectTitle = project["title"];
    projectHref = project["href"];
    final workPackage = links["workPackage"];
    workPackageSubject = workPackage["title"];
    workPackageHref = workPackage["href"];

    final hoursString = json["hours"];
    hours =
        Duration(seconds: IsoDuration.parse(hoursString).toSeconds().round());
    if (hours.inSeconds.remainder(60) == 59) {
      hours += const Duration(seconds: 1);
    }
  }
}

class TimeEntriesResponse {
  late List<TimeEntryResponse> timeEntries;

  TimeEntriesResponse.fromJson(Map<String, dynamic> json) {
    List<TimeEntryResponse> items = [];
    final embedded = json['_embedded'];
    final elements = embedded['elements'] as List<dynamic>;
    for (var element in elements) {
      items.add(TimeEntryResponse.fromJson(element));
    }
    timeEntries = items;
  }
}
