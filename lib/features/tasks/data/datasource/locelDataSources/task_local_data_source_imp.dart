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
    final maps = await db.rawQuery('''
      SELECT tasks.*, category_of_task.category_name 
      FROM tasks 
      LEFT JOIN category_of_task ON tasks.category_id = category_of_task.id
    ''');

    final tasksList = maps.map((task) => TaskModel.fromMap(task)).toList();
    if (tasksList.isEmpty) return [];

    final taskIds = tasksList.map((t) => t.id).toList();
    final placeholders = List.filled(taskIds.length, '?').join(',');
    final subMaps = await db.query(
      'sub_tasks',
      where: 'task_id IN ($placeholders)',
      whereArgs: taskIds,
    );

    final subTasksMap = <int, List<SubTaskModel>>{};
    for (var subMap in subMaps) {
      final subModel = SubTaskModel.fromMap(subMap);
      subTasksMap.putIfAbsent(subModel.taskId, () => []).add(subModel);
    }

    for (var task in tasksList) {
      task.subTasks = subTasksMap[task.id] ?? [];
    }

    return tasksList;
  }

  //ToDo Solve error in insertTask and database table relationship
  @override
  Future<void> insertTask(TaskModel task) async {
    log("Attempting to insert task: ${task.toMap()}");
    try {
      final db = await databaseHelper.database;
      final taskId = await db.insert('tasks', task.toMap());
      log("Successfully inserted task with assigned ID: $taskId");
      if (task.subTasks != null && task.subTasks!.isNotEmpty) {
        log("Inserting ${task.subTasks!.length} subtasks for task ID $taskId");
        for (var sub in task.subTasks!) {
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
    if (tasksList.isEmpty) return [];

    final taskIds = tasksList.map((t) => t.id).toList();
    final placeholders = List.filled(taskIds.length, '?').join(',');
    final subMaps = await db.query(
      'sub_tasks',
      where: 'task_id IN ($placeholders)',
      whereArgs: taskIds,
    );

    final subTasksMap = <int, List<SubTaskModel>>{};
    for (var subMap in subMaps) {
      final subModel = SubTaskModel.fromMap(subMap);
      subTasksMap.putIfAbsent(subModel.taskId, () => []).add(subModel);
    }

    for (var task in tasksList) {
      task.subTasks = subTasksMap[task.id] ?? [];
    }

    return tasksList;
  }

  @override
  Future<void> completeSubTask(String subTaskId, bool taskState) async {
    final db = await databaseHelper.database;

    await db.update(
      'sub_tasks',
      {'is_completed': taskState == true ? 1 : 0},
      where: 'id = ?',
      whereArgs: [subTaskId],
    );
  }

  @override
  Future<void> completeTask(String taskId) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      {'isDone': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  @override
  Future<void> extendDeadline(int taskId, DateTime newDeadline) async {
    final db = await databaseHelper.database;
    final existing = await db.query(
      'tasks',
      columns: ['date', 'deadline_extended', 'original_deadline'],
      where: 'id = ?',
      whereArgs: [taskId],
    );
    if (existing.isEmpty) return;
    final row = existing.first;
    final wasExtended = row['deadline_extended'] == 1;
    await db.update(
      'tasks',
      {
        'date': newDeadline.toIso8601String(),
        'deadline_extended': 1,
        if (!wasExtended) 'original_deadline': row['date'],
        'extended_deadline': newDeadline.toIso8601String(),
      },
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
