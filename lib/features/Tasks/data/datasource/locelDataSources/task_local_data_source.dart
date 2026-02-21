import 'package:tasks_manager/features/Tasks/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> insertTask(TaskModel task);
  Future<List<TaskModel>> getTasks();
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> addCategory(String category);
  Future<List<Map<String, dynamic>>> getCategories();
  Future<List<TaskModel>> getTasksByCategory(String category);
}
