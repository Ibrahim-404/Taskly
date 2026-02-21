import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class GetCategories {
  final TaskRepo taskRepo;
  GetCategories(this.taskRepo);

  Future<Either<Failure, List<String>>> call() async {
    return await taskRepo.getCategories();
  }
}
