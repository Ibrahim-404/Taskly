import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/features/Core/database/Tables/tasksDataTable.dart';

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
  return await openDatabase(path, version: 1, onCreate: _onCreate);
}

Future<void> _onCreate(Database db, int version) async {
  await Tasksdatatable().createTasksTable(db);
}
