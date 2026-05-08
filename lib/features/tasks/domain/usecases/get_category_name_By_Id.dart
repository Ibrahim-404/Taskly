import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class GetCategoryNameById {
  final TaskRepo repo;
  GetCategoryNameById(this.repo);
  Future<Either<Failure, String>> call(String id) async {
    return await repo.getCategoryNameById(id);
  }
}
