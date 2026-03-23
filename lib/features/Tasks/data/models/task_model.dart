import 'package:tasks_manager/features/Tasks/data/models/sub_task_model.dart';

class TaskModel {
  List<SubTaskModel>? subTask;
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime date;
  TaskModel({
    this.subTask = const [],
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.date,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(
      subTask:
          (json['sub_task'] as List?)
              ?.map((x) => SubTaskModel.fromMap(x))
              .toList() ??
          [],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['is_completed'] == 1 || json['is_completed'] == true,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sub_task': subTask?.map((x) => x.toMap()).toList() ?? [],
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isDone,
      'date': date.toIso8601String(),
    };
  }
}
