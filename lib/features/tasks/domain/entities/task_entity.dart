import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';

class TaskEntity {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;
  final int categoryId;
  final List<SubTaskEntity> subTasks;
  final String priorityStatus;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
    required this.categoryId,
    this.subTasks = const [],
    this.priorityStatus = 'low',
  });
}
