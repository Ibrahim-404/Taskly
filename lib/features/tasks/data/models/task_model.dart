import 'package:tasks_manager/features/tasks/data/models/sub_task_model.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';

class TaskModel {
  List<SubTaskModel>? subTasks;
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final int categoryId;
  final String? categoryName;
  final DateTime date;
  final TaskPriority priorityStatus;
  final bool deadlineExtended;
  final DateTime? originalDeadline;
  final DateTime? extendedDeadline;

  TaskModel({
    this.subTasks = const [],
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.categoryId,
    this.categoryName,
    required this.date,
    required this.priorityStatus,
    this.deadlineExtended = false,
    this.originalDeadline,
    this.extendedDeadline,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    DateTime? parseNullable(String? val) {
      if (val == null || val.isEmpty) return null;
      return DateTime.tryParse(val);
    }

    return TaskModel(
      subTasks:
          (json['sub_tasks'] as List?)
              ?.map((x) => SubTaskModel.fromMap(x))
              .toList() ??
          [],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'] == 1 || json['isDone'] == true,
      date: DateTime.parse(json['date']),
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'],
      priorityStatus: TaskPriority.fromValue(json['priority']),
      deadlineExtended: json['deadline_extended'] == 1 || json['deadline_extended'] == true,
      originalDeadline: parseNullable(json['original_deadline']),
      extendedDeadline: parseNullable(json['extended_deadline']),
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
      'deadline_extended': deadlineExtended ? 1 : 0,
    };
    if (originalDeadline != null) {
      map['original_deadline'] = originalDeadline!.toIso8601String();
    }
    if (extendedDeadline != null) {
      map['extended_deadline'] = extendedDeadline!.toIso8601String();
    }
    if (id != 0) {
      map['id'] = id;
    }
    return map;
  }
}
