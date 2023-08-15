import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/state_manager/Cancelled_task_screen_controller.dart';
import 'package:todo/ui/state_manager/In_Progress_Task_Controller.dart';
import 'package:todo/ui/state_manager/completed_task_controller.dart';

import '../state_manager/New_Task_Controller.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'in_progress_task_screen.dart';
import 'new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  final RxInt _selectedScreenIndex = 0.obs;
  final List<Widget> _screens = [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskscreen(),
    CompletedTaskscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[_selectedScreenIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex.value,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        onTap: (int index) {
          _selectedScreenIndex.value = index;
          if (index == 0) {
            final newTaskController = Get.find<NewTaskController>();
            newTaskController.refreshTasks();
          } else if (index == 1) {
            final inProgressController = Get.find<InProgressTaskController>();
            inProgressController.getInProgressTasks();
          } else if (index == 2) {
            final CancelledController = Get.find<CancelledTaskController>();
            CancelledController.refreshTasks();
          } else if (index == 3) {
            final completedController = Get.find<CompletedTaskController>();
            completedController.refreshTasks();
          }
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree), label: 'In Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed'),
        ],
      ),
    );
  }
}
