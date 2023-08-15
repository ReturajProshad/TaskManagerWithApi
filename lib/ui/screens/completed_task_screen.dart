import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/state_manager/completed_task_controller.dart';
import 'package:todo/ui/widgets/task_list_tile.dart';
import 'package:todo/ui/widgets/user_profile_banner.dart';

class CompletedTaskscreen extends StatelessWidget {
  final CompletedTaskController controller = Get.put(CompletedTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: () {}),
            Expanded(
              child: Obx(
                () => controller.getCompletedTasksInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await controller.getCompletedTasks();
                        },
                        child: ListView.separated(
                          itemCount: controller.taskListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: controller.taskListModel.data![index],
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
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
