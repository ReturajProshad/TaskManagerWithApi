import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/state_manager/In_Progress_Task_Controller.dart';

import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';

class InProgressTaskScreen extends StatefulWidget {
  InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final InProgressTaskController controller =
      Get.put(InProgressTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: () {
              controller.getInProgressTasks();
            }),
            Expanded(
              child: Obx(() => controller.getProgressTasksInProgress.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        controller.getInProgressTasks();
                      },
                      child: ListView.separated(
                        itemCount:
                            controller.taskListModel.value.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: controller.taskListModel.value.data![index],
                            onTaskDeleted: controller.refreshTasks,
                            onTaskStatusChange: controller.refreshTasks,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
