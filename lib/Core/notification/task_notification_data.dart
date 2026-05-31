import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskNotificationData {
  final int id;
  final String taskId;
  final String title;
  final String body;
  final String type;
  final String payload;
  final NotificationDetails platformDetails;

  TaskNotificationData({
    required this.id,
    required this.taskId,
    required this.title,
    required this.body,
    required this.type,
    required this.payload,
    required this.platformDetails,
  });
}
