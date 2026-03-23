import 'package:tasks_manager/features/Tasks/data/models/sub_task_model.dart';
import 'package:tasks_manager/features/Tasks/data/models/task_model.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';

extension TaskModelMapper on TaskModel {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      date: date,
      isDone: isDone,
      subTasks: subTask?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension SubTaskModelMapper on SubTaskModel {
  SubTaskEntity toEntity() {
    return SubTaskEntity(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
      taskId: taskId,
    );
  }
}
