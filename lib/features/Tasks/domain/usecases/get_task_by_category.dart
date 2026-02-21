import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class GetTasksByCategoryUseCase {
  final TaskRepo taskRepo;

  GetTasksByCategoryUseCase(this.taskRepo);

  Future<Either<Failure, List<TaskEntity>>> call(String category) async {
    return await taskRepo.getTasksByCategory(category);
  }
}
