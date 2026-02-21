import 'package:dartz/dartz.dart';
import 'package:tasks_manager/features/Core/errors%20handler/failuer.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';

class AddCategory {
  final TaskRepo taskRepo;
  AddCategory(this.taskRepo);
  Future<Either<Failure, Unit>> call(String category) async {
    return await taskRepo.addCategory(category);
  }
}
