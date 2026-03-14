import 'package:dartz/dartz.dart';
import 'package:tasks_manager/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/Core/errors%20handler/failuer_imp.dart';

import 'package:tasks_manager/features/Tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/Tasks/data/models/mapper/task_mapper_entity.dart';
import 'package:tasks_manager/features/Tasks/data/models/mapper/task_mapper_model.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class TaskRepoImp implements TaskRepo {
  TaskLocalDataSource taskLocalDataSource;
  TaskRepoImp({required this.taskLocalDataSource});
  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    try {
      await taskLocalDataSource.insertTask(task.toModel());
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int taskId) async {
    try {
      await taskLocalDataSource.deleteTask(taskId);
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final taskModels = await taskLocalDataSource.getTasks();

      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch tasks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskEntity task) async {
    try {
      await taskLocalDataSource.updateTask(task.toModel());
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCategory(String category) async {
    try {
      await taskLocalDataSource.addCategory(category);
      return Right(unit);
    } catch (e) {
      return Left(StorageFailure('Failed to add category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getCategories() async {
    try {
      final categories = await taskLocalDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(
        StorageFailure('Failed to fetch categories: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksByCategory(
    String category,
  ) async {
    try {
      final taskModels = await taskLocalDataSource.getTasksByCategory(category);
      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } catch (e) {
      return Left(
        StorageFailure('Failed to fetch tasks by category: ${e.toString()}'),
      );
    }
  }
}
