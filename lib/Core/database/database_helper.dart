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
    version: 5,
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
  if (oldVersion < 5) {
    final tableInfo = await db.rawQuery('PRAGMA table_info(tasks)');
    final hasExtended = tableInfo.any(
      (column) => column['name'] == 'deadline_extended',
    );
    if (!hasExtended) {
      await db.execute(
        'ALTER TABLE tasks ADD COLUMN deadline_extended INTEGER NOT NULL DEFAULT 0',
      );
    }
    final hasOriginal = tableInfo.any(
      (column) => column['name'] == 'original_deadline',
    );
    if (!hasOriginal) {
      await db.execute(
        'ALTER TABLE tasks ADD COLUMN original_deadline TEXT',
      );
    }
    final hasExtendedDeadline = tableInfo.any(
      (column) => column['name'] == 'extended_deadline',
    );
    if (!hasExtendedDeadline) {
      await db.execute(
        'ALTER TABLE tasks ADD COLUMN extended_deadline TEXT',
      );
    }
  }
}
