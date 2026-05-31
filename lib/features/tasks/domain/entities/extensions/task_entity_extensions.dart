import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasks_manager/core/notification/task_notification_data.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';

extension TaskEntityToNotificationData on TaskEntity {
  TaskNotificationData toNotificationData() {
    return TaskNotificationData(
      id: id,
      taskId: id.toString(),
      title: title,
      body: 'Due in less than 24 hours',
      type: 'task_due_soon',
      payload: id.toString(),
      platformDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel',
          'Task Notifications',
          channelDescription: 'Notifications for upcoming tasks',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
