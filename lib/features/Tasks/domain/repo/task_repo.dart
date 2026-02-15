import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';

abstract class TaskRepo {
  Future<Either<Failure, Unit>> addTask(TaskEntity task);
  Future<Either<Failure, Unit>> deleteTask(String taskId);
  Future<Either<Failure, Unit>> updateTask(TaskEntity task);
  Future<Either<Failure, List<TaskEntity>>> getTasks();
}
