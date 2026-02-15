import 'package:tasks_manager/features/Tasks/data/models/task_model.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';

extension TaskEntityExtension on TaskModel {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      date: date,
      isDone: isDone,
    );
  }
}
