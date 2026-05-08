import 'dart:developer';

import 'package:sqflite/sql.dart';
import 'package:tasks_manager/core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/features/tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/tasks/data/models/task_model.dart';
import 'package:tasks_manager/features/tasks/data/models/sub_task_model.dart';

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
    print("Executing getTasks...");
    final maps = await db.rawQuery('''
      SELECT tasks.*, category_of_task.category_name 
      FROM tasks 
      LEFT JOIN category_of_task ON tasks.category_id = category_of_task.id
    ''');
    print("getTasks returned ${maps.length} rows: $maps");
    final tasksList = maps.map((task) {
      try {
        return TaskModel.fromMap(task);
      } catch (e) {
        print("Error parsing task fromMap: $e");
        rethrow;
      }
    }).toList();
    for (var task in tasksList) {
      final subMaps = await db.query(
        'sub_tasks',
        where: 'task_id = ?',
        whereArgs: [task.id],
      );
      task.subTask = subMaps.map((e) => SubTaskModel.fromMap(e)).toList();
    }
    return tasksList;
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    log("Attempting to insert task: ${task.toMap()}");
    try {
      final db = await databaseHelper.database;
      final taskId = await db.insert('tasks', task.toMap());
      log("Successfully inserted task with assigned ID: $taskId");
      if (task.subTask != null && task.subTask!.isNotEmpty) {
        log("Inserting ${task.subTask!.length} subtasks for task ID $taskId");
        for (var sub in task.subTask!) {
          var subMap = sub.toMap();
          subMap['task_id'] = taskId;
          await db.insert('sub_tasks', subMap);
        }
      }
    } catch (e) {
      print("Exception during insertTask: $e");
      rethrow;
    }
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

  @override
  Future<void> addCategory(String category) async {
    final db = await databaseHelper.database;
    await db.insert('category_of_task', {
      'category_name': category,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await databaseHelper.database;
    final maps = await db.query('category_of_task');
    return maps;
  }

  @override
  Future<List<TaskModel>> getTasksByCategory(String category) async {
    final db = await databaseHelper.database;
    final maps = await db.rawQuery(
      '''
      SELECT tasks.*, category_of_task.category_name FROM tasks
      INNER JOIN category_of_task ON tasks.category_id = category_of_task.id
      WHERE category_of_task.category_name = ?
    ''',
      [category],
    );

    final tasksList = maps.map((task) => TaskModel.fromMap(task)).toList();
    for (var task in tasksList) {
      final subMaps = await db.query(
        'sub_tasks',
        where: 'task_id = ?',
        whereArgs: [task.id],
      );
      task.subTask = subMaps.map((e) => SubTaskModel.fromMap(e)).toList();
    }
    return tasksList;
  }

  @override
  Future<void> completeSubTask(String subTaskId) async {
    final db = await databaseHelper.database;
    await db.update(
      'sub_tasks',
      {'is_completed': 1},
      where: 'id = ?',
      whereArgs: [subTaskId],
    );
  }

  //TODO: we need to add complete sub task by sub task id, not by task id, because we can have multiple sub tasks for one task, and we want to complete only one of them, not all of them.
  @override
  Future<void> completeTask(String taskId) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      {'is_completed': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  @override
  Future<String> getCategoryNameById(String id) async {
    try {
      final db = await databaseHelper.database;
      final res = await db.query(
        'category_of_task',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (res.isNotEmpty) {
        return res.first['category_name'] as String;
      }
      return 'Unknown';
    } on Exception catch (e) {
      log("error when get category name by id ${e.toString()}");
      return 'Unknown';
    }
  }
}
