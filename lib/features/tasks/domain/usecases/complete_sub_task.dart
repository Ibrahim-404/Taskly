import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class CompleteSubTask {
  final TaskRepo taskRepo;
  const CompleteSubTask(this.taskRepo);
  Future<Either<Failure, Unit>> call(String taskId) =>
      taskRepo.completeSubTask(taskId);
}
