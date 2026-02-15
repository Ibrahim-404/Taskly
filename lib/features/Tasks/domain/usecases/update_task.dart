import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class UpdateTask {
  final TaskRepo taskRepo;
  UpdateTask(this.taskRepo);
  Future<Either<Failure, Unit>> call(TaskEntity task) async {
    return await taskRepo.updateTask(task);
  }
}
