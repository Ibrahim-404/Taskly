import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';

class TaskEntity {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;
  final int categoryId;
  final String? categoryName;
  final List<SubTaskEntity> subTasks;
  final TaskPriority priorityStatus;
  final bool deadlineExtended;
  final DateTime? originalDeadline;
  final DateTime? extendedDeadline;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
    required this.categoryId,
    this.categoryName,
    this.subTasks = const [],
    this.priorityStatus = TaskPriority.low,
    this.deadlineExtended = false,
    this.originalDeadline,
    this.extendedDeadline,
  });

  bool get isMissed => !isDone && date.isBefore(DateTime.now());
  bool get isUpcoming => !isDone && !date.isBefore(DateTime.now());

  factory TaskEntity.skeleton() {
    return TaskEntity(
      id: 0,
      title: 'Task Title Placeholder',
      description: 'This is a description placeholder for skeleton loading',
      date: DateTime.now(),
      isDone: false,
      categoryId: 0,
      categoryName: 'Category',
      priorityStatus: TaskPriority.low,
      subTasks: [],
    );
  }
}
