import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasks_manager/core/notification/task_notification_data.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init({
    required void Function(NotificationResponse) onNotificationTap,
  }) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  Future<bool> requestPermissions() async {
    final android = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
    final ios = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      await ios.requestPermissions(alert: true, badge: true, sound: true);
    }
    return true;
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

  Future<void> cancel(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(id: notificationId);
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
