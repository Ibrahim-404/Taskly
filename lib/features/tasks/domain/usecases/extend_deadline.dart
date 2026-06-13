import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class ExtendDeadline {
  final TaskRepo taskRepo;
  ExtendDeadline(this.taskRepo);

  Future<Either<Failure, Unit>> call(int taskId, DateTime newDeadline) async {
    return await taskRepo.extendDeadline(taskId, newDeadline);
  }
}
