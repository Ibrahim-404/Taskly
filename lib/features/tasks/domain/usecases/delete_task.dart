import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class DeleteTask {
  final TaskRepo taskRepo;
  DeleteTask(this.taskRepo);
  Future<Either<Failure, Unit>> call(int taskId) async {
    return await taskRepo.deleteTask(taskId);
  }
}
