import 'package:dartz/dartz.dart';
import 'package:tasks_manager/core/errors/failure.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';

class GetUpcomingTasks {
  final TaskRepo taskRepo;

  GetUpcomingTasks(this.taskRepo);

  Future<Either<Failure, List<TaskEntity>>> call() async {
    final result = await taskRepo.getTasks();
    return result.fold((failure) => Left(failure), (tasks) {
      final now = DateTime.now();
      final oneDayFromNow = now.add(const Duration(hours: 24));

      final upcomingTasks = tasks.where((task) {
        return !task.isDone &&
            task.date.isAfter(now) &&
            task.date.isBefore(oneDayFromNow);
      }).toList();

      return Right(upcomingTasks);
    });
  }
}
