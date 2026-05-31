import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasks_manager/core/notification/task_notification_data.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init({
    required void Function(NotificationResponse) onNotificationTap,
  }) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  Future<void> show(TaskNotificationData details) async {
    await flutterLocalNotificationsPlugin.show(
      id: details.id,
      body: details.body,
      notificationDetails: details.platformDetails,
      payload: details.payload,
      title: details.title,
    );
  }
}
