import 'package:tasks_manager/Core/errors%20handler/failuer.dart';

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class StorageFailure extends Failure {
  StorageFailure(super.message);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure(super.message);
}
