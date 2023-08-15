import 'package:get/get.dart';
import 'package:todo/data/models/task_list_model.dart';
import 'package:todo/data/services/network_caller.dart';
import 'package:todo/data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  final RxBool _getCancelledTasks = false.obs;
  final Rx<TaskListModel> _taskListModel = TaskListModel().obs;

  bool get getCancelledTasksInProgress => _getCancelledTasks.value;
  TaskListModel get taskListModel => _taskListModel.value;

  Future<void> getCancelledTasks() async {
    _getCancelledTasks.value = true;

    final response = await NetworkCaller().getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      _taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Error', 'Failed to get cancelled tasks');
    }

    _getCancelledTasks.value = false;
  }

  void refreshTasks() async {
    await getCancelledTasks();
  }

  @override
  void onInit() {
    super.onInit();
    getCancelledTasks();
  }
}
