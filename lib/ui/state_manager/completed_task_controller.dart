import 'package:get/get.dart';
import 'package:todo/data/models/task_list_model.dart';
import 'package:todo/data/services/network_caller.dart';
import 'package:todo/data/utils/urls.dart';

class CompletedTaskController extends GetxController {
  final RxBool _getCompletedTasks = false.obs;
  final Rx<TaskListModel> _taskListModel = TaskListModel().obs;

  bool get getCompletedTasksInProgress => _getCompletedTasks.value;
  TaskListModel get taskListModel => _taskListModel.value;

  Future<void> getCompletedTasks() async {
    _getCompletedTasks.value = true;

    final response = await NetworkCaller().getRequest(Urls.completedTask);
    if (response.isSuccess) {
      _taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Error', 'Failed to get completed tasks');
    }

    _getCompletedTasks.value = false;
  }

  void refreshTasks() async {
    await getCompletedTasks();
  }

  @override
  void onInit() {
    super.onInit();
    getCompletedTasks();
  }
}
