import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/time_entries_provider.dart';
import '/screens/time_entries_list/time_entry_list_item.dart';
import '/screens/time_entries_list/total_time_list_item.dart';
import '/helpers/app_router.dart';
import '/widgets/activity_indicator.dart';
import '/models/network_provider.dart';

class TimeEntriesListScreen extends StatefulWidget {
  const TimeEntriesListScreen({super.key});

  @override
  State<TimeEntriesListScreen> createState() => _TimeEntriesListScreenState();
}

class _TimeEntriesListScreenState extends State<TimeEntriesListScreen>
    with WidgetsBindingObserver {
  // Properties

  late Future _listFuture;

  // Private methods

  void _reloadList() async {
    _listFuture =
        Provider.of<TimeEntriesProvider>(context, listen: false).reload();
  }

  // Lifecycle

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _reloadList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _reloadList();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent work'),
        leading: IconButton(
            onPressed: (() =>
                Provider.of<NetworkProvider>(context, listen: false)
                    .unauthorize()),
            icon: const Icon(Icons.exit_to_app_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: FutureBuilder(
          future: _listFuture,
          builder: ((context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: ActivityIndicator())
                : Consumer<TimeEntriesProvider>(
                    builder: (context, timeEntries, child) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<TimeEntriesProvider>(context,
                                  listen: false)
                              .reload();
                          setState(() {});
                        },
                        child: ListView.builder(
                          itemCount: timeEntries.items.length + 1,
                          itemBuilder: ((context, index) {
                            if (index == 0) {
                              return TotalTimeListItem(
                                  timeEntries.totalDuration);
                            }
                            final timeEntry = timeEntries.items[index - 1];
                            return TimeEntryListItem(
                              workPackageSubject: timeEntry.workPackageSubject,
                              projectTitle: timeEntry.projectTitle,
                              hours: timeEntry.hours,
                              comment: timeEntry.comment,
                              action: () => AppRouter.routeToTimer(
                                context,
                                timeEntry,
                                widget,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => AppRouter.routeToWorkPackagesList(context),
      ),
    );
  }
}
