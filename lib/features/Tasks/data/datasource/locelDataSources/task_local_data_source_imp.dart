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
    final maps = await db.query('tasks');
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
    print("Attempting to insert task: ${task.toMap()}");
    try {
      final db = await databaseHelper.database;
      final taskId = await db.insert('tasks', task.toMap());
      print("Successfully inserted task with assigned ID: $taskId");
      if (task.subTask != null && task.subTask!.isNotEmpty) {
        print("Inserting ${task.subTask!.length} subtasks for task ID $taskId");
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
      SELECT tasks.* FROM tasks
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
}
