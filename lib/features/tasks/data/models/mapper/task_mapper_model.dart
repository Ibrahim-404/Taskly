import 'package:tasks_manager/features/tasks/data/models/sub_task_model.dart';
import 'package:tasks_manager/features/tasks/data/models/task_model.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';

extension TaskModelExtension on TaskEntity {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      date: date,
      isDone: isDone,
      categoryId: categoryId,
      subTask: subTasks.map((e) => e.toModel()).toList(),
      priorityStatus: priorityStatus,
    );
  }
}

extension SubTaskEntityExtension on SubTaskEntity {
  SubTaskModel toModel() {
    return SubTaskModel(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
      taskId: taskId,
    );
  }
}
