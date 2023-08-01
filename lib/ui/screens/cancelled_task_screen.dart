import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';

class CancelledTaskscreen extends StatefulWidget {
  const CancelledTaskscreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskscreen> createState() => _CancelledTaskscreenState();
}

class _CancelledTaskscreenState extends State<CancelledTaskscreen> {
  bool _getCancelledTasks = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getCancelledTasks() async {
    _getCancelledTasks = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('In progress tasks get failed')));
      }
    }
    _getCancelledTasks = false;
    if (mounted) {
      setState(() {});
    }
  }

  void refreshTasks() async {
    getCancelledTasks();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCancelledTasks();
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
              child: _getCancelledTasks
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        getCancelledTasks();
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
