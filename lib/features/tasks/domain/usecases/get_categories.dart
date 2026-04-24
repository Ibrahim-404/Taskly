import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class GetCategories {
  final TaskRepo taskRepo;
  GetCategories(this.taskRepo);

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    return await taskRepo.getCategories();
  }
}
