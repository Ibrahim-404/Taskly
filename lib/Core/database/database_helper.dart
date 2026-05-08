import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/core/database/Tables/category_of_task.dart';
import 'package:tasks_manager/core/database/Tables/sub_task_table.dart';
import 'package:tasks_manager/core/database/Tables/tasksDataTable.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
}

Future<Database> _initDatabase() async {
  String path = join(await getDatabasesPath(), 'tasks_manager.db');
  return await openDatabase(
    path,
    version: 4, // Bumped version to trigger migration
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
  );
}

Future<void> _onCreate(Database db, int version) async {
  await Tasksdatatable().createTasksTable(db);
  await CategoryOfTask().addANewCategory(db);
  await SubTaskTable().createSubTasksTable(db);
  await db.insert('category_of_task', {'category_name': 'life'});
}

Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
if (oldVersion < 4) {
  final tableInfo = await db.rawQuery('PRAGMA table_info(tasks)');
  final hasPriorityColumn = tableInfo.any(
    (column) => column['name'] == 'priority',
  );

  if (!hasPriorityColumn) {
    await db.execute(
      'ALTER TABLE tasks ADD COLUMN priority INTEGER NOT NULL DEFAULT 0',
    );
  }
}
}
//curent version is 4 because we added priority column to tasks table and sub_tasks table, so we need to bump the version to trigger the migration and add the new column to the existing tables.