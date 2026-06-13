import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/core/database/Tables/category_of_task.dart';

class Tasksdatatable {
  static const String tableName = 'tasks';
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String isDone = 'isDone';
  static const String date = 'date';
  static const String priority = 'priority';
  static const String categoryId = 'category_id';
  static const String deadlineExtended = 'deadline_extended';
  static const String originalDeadline = 'original_deadline';
  static const String extendedDeadline = 'extended_deadline';

  Future<void> createTasksTable(Database db) async {
    await db.execute(createTasksTableQuery());
  }

  static String createTasksTableQuery() {
    return '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT NOT NULL,
      $description TEXT NOT NULL,
      $isDone INTEGER NOT NULL,
      $date TEXT NOT NULL,
      $priority INTEGER NOT NULL,
      $categoryId INTEGER,
      $deadlineExtended INTEGER NOT NULL DEFAULT 0,
      $originalDeadline TEXT,
      $extendedDeadline TEXT,
      FOREIGN KEY ($categoryId)
      REFERENCES ${CategoryOfTask.tableName}(${CategoryOfTask.id}) 
      ON DELETE SET NULL
    )
  ''';
  }
}
