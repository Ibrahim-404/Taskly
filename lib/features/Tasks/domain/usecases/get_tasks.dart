import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class GetTasks {
  final TaskRepo taskRepo;
  GetTasks(this.taskRepo);
  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await taskRepo.getTasks();
  }
}