import 'package:tasks_manager/core/errors/failure.dart';

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class StorageFailure extends Failure {
  StorageFailure(super.message);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure(super.message);
}
