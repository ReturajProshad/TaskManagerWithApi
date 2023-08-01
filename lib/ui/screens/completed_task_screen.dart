import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';

class CompletedTaskscreen extends StatefulWidget {
  const CompletedTaskscreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskscreen> createState() => _CompletedTaskscreenState();
}

class _CompletedTaskscreenState extends State<CompletedTaskscreen> {
  bool _getCompletedTasks = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getCompletedTasks() async {
    _getCompletedTasks = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('In progress tasks get failed')));
      }
    }
    _getCompletedTasks = false;
    if (mounted) {
      setState(() {});
    }
  }

  void refreshTasks() async {
    getCompletedTasks();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: () {}),
            Expanded(
              child: _getCompletedTasks
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        getCompletedTasks();
                      },
                      child: ListView.separated(
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
    );
  }
}
