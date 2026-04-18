import 'package:tasks_manager/features/tasks/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  
  Future<void> insertTask(TaskModel task);

  Future<List<TaskModel>> getTasks();
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  // Category related methods -- New Features
  Future<void> addCategory(String category);
  Future<List<Map<String, dynamic>>> getCategories();
  Future<List<TaskModel>> getTasksByCategory(String category);
}
