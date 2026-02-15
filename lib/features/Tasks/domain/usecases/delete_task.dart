import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class DeleteTask {
  final TaskRepo taskRepo;
  DeleteTask(this.taskRepo);
  Future<Either<Failure, Unit>> call(int taskId) async {
    return await taskRepo.deleteTask(taskId);
  }
}
