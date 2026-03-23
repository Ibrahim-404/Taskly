import 'package:sqflite/sqflite.dart';

class SubTaskTable {
  static const String tableName = 'sub_tasks';
  static const String subTaskId = 'id';
  static const String columnTaskId = 'task_id';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnIsCompleted = 'is_completed';
  Future<void> createSubTasksTable(Database db) async {
    await db.execute(createTableQuery());
  }

  static String createTableQuery() {
    return '''
    CREATE TABLE $tableName (
      $subTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTaskId INTEGER NOT NULL,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT,
      $columnIsCompleted INTEGER NOT NULL,
      FOREIGN KEY ($columnTaskId) REFERENCES tasks(id) ON DELETE CASCADE
    )
  ''';
  }
}
