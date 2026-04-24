import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class UpdateTask {
  final TaskRepo taskRepo;
  UpdateTask(this.taskRepo);
  Future<Either<Failure, Unit>> call(TaskEntity task) async {
    return await taskRepo.updateTask(task);
  }
}
