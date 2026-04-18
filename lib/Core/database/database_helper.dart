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
  String path = await join(await getDatabasesPath(), 'tasks_manager.db');
  return await openDatabase(path, version: 3, onCreate: _onCreate);
}

Future<void> _onCreate(Database db, int version) async {
  await Tasksdatatable().createTasksTable(db);
  await CategoryOfTask().addANewCategory(db);
  await SubTaskTable().createSubTasksTable(db);
  await db.insert('category_of_task', {'category_name': 'life'});
}
