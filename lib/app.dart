import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/screens/splash_screen.dart';
import 'package:todo/ui/state_manager/Cancelled_task_screen_controller.dart';
import 'package:todo/ui/state_manager/In_Progress_Task_Controller.dart';
import 'package:todo/ui/state_manager/completed_task_controller.dart';
import 'package:todo/ui/state_manager/email_verification_controller.dart';
import 'package:todo/ui/state_manager/signup_screen_controller.dart';

import 'ui/state_manager/add_new_task_controller.dart';
import 'ui/state_manager/login_controller.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      initialBinding: ControllerBinding(),
      home: const SplashScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<InProgressTaskController>(InProgressTaskController());
    Get.put<CancelledTaskController>(CancelledTaskController());
    Get.put<CompletedTaskController>(CompletedTaskController());
    Get.put<SignUpController>(SignUpController());
    Get.put<EmailVerificationController>(EmailVerificationController());
  }
}
