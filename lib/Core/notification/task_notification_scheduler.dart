import 'dart:developer' show log;

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:tasks_manager/core/notification/notfication.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_upcoming_tasks.dart';
import 'package:tasks_manager/features/tasks/domain/entities/extensions/task_entity_extensions.dart';
import 'package:workmanager/workmanager.dart';

class TaskNotificationScheduler {
  final NotificationService notificationService;
  final GetUpcomingTasks getUpcomingTasks;

  static const String taskNotificationWorkTag = 'task-notification-work';

  TaskNotificationScheduler({
    required this.notificationService,
    required this.getUpcomingTasks,
  });

  Future<void> initScheduler() async {
    try {
      await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

      await Workmanager().registerPeriodicTask(
        taskNotificationWorkTag,
        'checkUpcomingTasks',
        frequency: const Duration(hours: 12),
        initialDelay: const Duration(minutes: 1),
      );
    } catch (e) {
      log('Error initializing scheduler: $e');
    }
  }

  Future<void> cancelScheduler() async {
    try {
      await Workmanager().cancelByTag(taskNotificationWorkTag);
    } catch (e) {
      log('Error canceling scheduler: $e');
    }
  }

  Future<void> checkAndNotifyUpcomingTasks() async {
    try {
      final result = await getUpcomingTasks();

      result.fold(
        (failure) {
          log('Failed to get upcoming tasks: $failure');
        },
        (upcomingTasks) {
          for (var task in upcomingTasks) {
            notificationService.show(task.toNotificationData());
          }
        },
      );
    } catch (e) {
      log('Error checking upcoming tasks: $e');
    }
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      if (taskName == 'checkUpcomingTasks') {
        final scheduler = Get.find<TaskNotificationScheduler>();
        await scheduler.checkAndNotifyUpcomingTasks();
        return true;
      }
      return false;
    } catch (e) {
      log('Error in background task: $e');
      return false;
    }
  });
}
