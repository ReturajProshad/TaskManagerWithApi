import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/state_manager/Cancelled_task_screen_controller.dart';
import 'package:todo/ui/widgets/task_list_tile.dart';
import 'package:todo/ui/widgets/user_profile_banner.dart';

class CancelledTaskscreen extends StatelessWidget {
  final CancelledTaskController controller = Get.put(CancelledTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: () {}),
            Expanded(
              child: Obx(
                () => controller.getCancelledTasksInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await controller.getCancelledTasks();
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
