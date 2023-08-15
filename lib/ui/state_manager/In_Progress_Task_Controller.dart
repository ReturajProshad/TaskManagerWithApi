import 'package:get/get.dart';
import 'package:todo/data/models/task_list_model.dart';
import 'package:todo/data/services/network_caller.dart';
import 'package:todo/data/utils/urls.dart';

class InProgressTaskController extends GetxController {
  var getProgressTasksInProgress = false.obs;
  var taskListModel = TaskListModel().obs;

  Future<void> getInProgressTasks() async {
    getProgressTasksInProgress.value = true;

    final response = await NetworkCaller().getRequest(Urls.inProgressTasks);
    if (response.isSuccess) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Error', 'Failed to get in progress tasks');
    }
    getProgressTasksInProgress.value = false;
  }

  void refreshTasks() {
    getInProgressTasks();
  }

  @override
  void onInit() {
    super.onInit();
    getInProgressTasks();
  }
}
