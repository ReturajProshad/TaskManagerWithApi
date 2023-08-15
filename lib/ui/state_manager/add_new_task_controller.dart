import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController descriptionTEController = TextEditingController();
  var addNewTaskInProgress = false.obs;

  Future<void> addNewTask(VoidCallback onAdded) async {
    addNewTaskInProgress.value = true;

    final requestBody = {
      "title": titleTEController.text.trim(),
      "description": descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);

    addNewTaskInProgress.value = false;

    if (response.isSuccess) {
      titleTEController.clear();
      descriptionTEController.clear();
      onAdded();
      Get.snackbar('Success', 'Task added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Failed to add task',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
