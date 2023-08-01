import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('get new task data failed')));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  void refreshTasks() async {
    getCountSummary();
    getNewTasks();
  }

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: () {
              // Call the getNewTasks() method to refresh the data
              getNewTasks();
              getCountSummary();
            }),
            _getCountSummaryInProgress
                ? const LinearProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: buildSummaryCards(),
                          ),
                        ],
                      ),
                    ),
                  ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTasks();
                  getCountSummary();
                },
                child: _getNewTaskInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _taskListModel.data![index],
                            onTaskDeleted: refreshTasks,
                            onTaskStatusChange: refreshTasks,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewTaskScreen(
                        onAdded: refreshTasks,
                      )));
        },
      ),
    );
  }

  Widget buildSummaryCards() {
    // Check if there is no summary data
    final bool hasSummaryData =
        _summaryCountModel.data != null && _summaryCountModel.data!.isNotEmpty;

    if (hasSummaryData) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _summaryCountModel.data!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SummaryCard(
                title: _summaryCountModel.data![index].sId ?? 'New',
                number: _summaryCountModel.data![index].sum ?? 0,
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 4,
          );
        },
      );
    } else {
      // If there is no summary data, show the Text widget
      return const Center(
        child: Text("NO ACTIONs RIGHT NOW, Add A Task,swipe Down To refresh"),
      );
    }
  }
}
