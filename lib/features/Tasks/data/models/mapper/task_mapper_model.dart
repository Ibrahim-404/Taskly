import 'package:tasks_manager/features/Tasks/data/models/task_model.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';

extension TaskModelExtension on TaskEntity {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      date: date,
      isDone: isDone,
    );
  }
}
