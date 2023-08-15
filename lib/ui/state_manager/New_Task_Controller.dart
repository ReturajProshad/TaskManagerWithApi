import 'package:get/get.dart';
import 'package:todo/data/services/network_caller.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/utils/urls.dart';

class NewTaskController extends GetxController {
  var getCountSummaryInProgress = false.obs;
  var getNewTaskInProgress = false.obs;
  var summaryCountModel = SummaryCountModel().obs;
  var taskListModel = TaskListModel().obs;

  Future<void> getCountSummary() async {
    getCountSummaryInProgress.value = true;
    final response = await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      summaryCountModel.value = SummaryCountModel.fromJson(response.body!);
    } else {
      Get.snackbar('Error', 'Failed to get task data');
    }
    getCountSummaryInProgress.value = false;
  }

  Future<void> getNewTasks() async {
    getNewTaskInProgress.value = true;
    final response = await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Error', 'Failed to get summary data');
    }
    getNewTaskInProgress.value = false;
  }

  void refreshTasks() {
    getCountSummary();
    getNewTasks();
  }

  @override
  void onInit() {
    super.onInit();
    getCountSummary();
    getNewTasks();
  }
}
