import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class CompleteTask {
  final TaskRepo taskRepo;
  CompleteTask(this.taskRepo);

  Future<Either<Failure, Unit>> call(String taskId) async {
    return await taskRepo.completeTask(taskId);
  }
}
