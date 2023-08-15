import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/user_profile_banner.dart';
import '../state_manager/add_new_task_controller.dart';

class AddNewTaskScreen extends StatelessWidget {
  final AddNewTaskController controller = Get.put(AddNewTaskController());
  final VoidCallback onAdded;

  AddNewTaskScreen({Key? key, required this.onAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileBanner(onRefresh: () {}),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Add new task',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.titleTEController,
                      decoration: const InputDecoration(hintText: 'Title'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: controller.descriptionTEController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => Visibility(
                            visible: !controller.addNewTaskInProgress.isTrue,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.titleTEController.text.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Title cannot be empty',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  controller.addNewTask(onAdded);
                                }
                              },
                              child: const Icon(Icons.arrow_forward_ios),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
