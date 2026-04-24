import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';

abstract class TaskRepo {
  Future<Either<Failure, Unit>> addTask(TaskEntity task);
  Future<Either<Failure, Unit>> deleteTask(int taskId);
  Future<Either<Failure, Unit>> updateTask(TaskEntity task);
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, List<TaskEntity>>> getTasksByCategory(String category);
  Future<Either<Failure, Unit>> addCategory(String category);
  Future<Either<Failure, List<Map<String, dynamic>>>> getCategories();
  Future<Either<Failure, Unit>> completeTask(String taskId);
  Future<Either<Failure, Unit>> completeSubTask(String taskId);
}
