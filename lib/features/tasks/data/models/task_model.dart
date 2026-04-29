import 'package:tasks_manager/features/tasks/data/models/sub_task_model.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';

class TaskModel {
  List<SubTaskModel>? subTask;
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final int categoryId;
  final DateTime date;
  final TaskPriority priorityStatus;
  TaskModel({
    this.subTask = const [],
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.categoryId,
    required this.date,
    required this.priorityStatus,
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
      isDone: json['isDone'] == 1 || json['isDone'] == true,
      date: DateTime.parse(json['date']),
      categoryId: json['category_id'] ?? 0,
      priorityStatus: TaskPriority.fromValue(json['priority']),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
      'category_id': categoryId,
      'date': date.toIso8601String(),
      'priority': priorityStatus.value,
    };
    if (id != 0) {
      map['id'] = id;
    }
    return map;
  }
}
