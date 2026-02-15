import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/features/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/features/Tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/Tasks/data/models/task_model.dart';

class TaskLocalDataSourceImp extends BaseLocalDataSource
    implements TaskLocalDataSource {
  TaskLocalDataSourceImp({required super.databaseHelper});

  @override
  Future<void> deleteTask(int id) async {
    final db = await databaseHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final db = await databaseHelper.database;
    final maps = await db.query('tasks');
    return maps.map((task) => TaskModel.fromMap(task)).toList();
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    final db = await databaseHelper.database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
