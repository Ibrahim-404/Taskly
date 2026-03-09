import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';

class BaseLocalDataSource {
 final DatabaseHelper databaseHelper;

  BaseLocalDataSource({required this.databaseHelper});
  Future<Database> getDatabase() async {
    return await databaseHelper.database;
  }
}
