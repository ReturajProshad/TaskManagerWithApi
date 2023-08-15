import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/summary_count_model.dart';
import '../state_manager/New_Task_Controller.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController controller = Get.put(NewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(onRefresh: controller.refreshTasks),
            Obx(() => controller.getCountSummaryInProgress.value
                ? LinearProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: buildSummaryCards(
                                controller.summaryCountModel.value),
                          ),
                        ],
                      ),
                    ),
                  )),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshTasks();
                },
                child: Obx(() => controller.getNewTaskInProgress.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
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
                      )),
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
                        onAdded: controller.refreshTasks,
                      )));
        },
      ),
    );
  }

  Widget buildSummaryCards(SummaryCountModel summaryCountModel) {
    final hasSummaryData =
        summaryCountModel.data != null && summaryCountModel.data!.isNotEmpty;

    if (hasSummaryData) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: summaryCountModel.data!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SummaryCard(
                title: summaryCountModel.data![index].sId ?? 'New',
                number: summaryCountModel.data![index].sum ?? 0,
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
      return const Center(
        child: Text("NO ACTIONS RIGHT NOW, Add A Task, Swipe Down To Refresh"),
      );
    }
  }
}
