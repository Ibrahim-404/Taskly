import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/const/app_strings.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/core/notification/notfication.dart';
import 'package:tasks_manager/core/notification/task_notification_scheduler.dart';
import 'package:tasks_manager/features/search/presentation/search_option_screen.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_show_dialog_for_add_new_task.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/build_all_tasks.dart';

class MainScreenController extends BaseController {
  final List<Widget> widgetOptions = <Widget>[
    // TaskMainScreen(),
    BuildAllTasks(),
    CustomShowDialogForAddNewTask(),
    SearchScreen(),
    Text(AppStrings.analyticsScreen),
  ];

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
  }

  void _initNotifications() async {
    try {
      final notificationService = Get.find<NotificationService>();
      await notificationService.init(
        onNotificationTap: (response) {
          final payload = response.payload;
          if (payload != null && payload.isNotEmpty) {
            updateSelectedIndex(0);

            // Allow tab change to finish, then trigger scroll
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Get.isRegistered<TaskController>()) {
                Get.find<TaskController>().scrollToTask(payload);
              }
            });
          }
        },
      );

      // Start the task scheduler to fetch upcoming tasks and schedule periodic background tasks
      final scheduler = Get.find<TaskNotificationScheduler>();
      await scheduler.initScheduler();
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }

  void updateSelectedIndex(int index) {
    _selectedIndex.value = index;
    update();
  }

  goToAddTaskScreen() {
    updateSelectedIndex(0);
  }
}
