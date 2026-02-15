import 'package:sqflite/sqflite.dart';
import 'package:tasks_manager/features/Core/database/database_helper.dart';

class BaseLocalDataSource {
  DatabaseHelper databaseHelper;

  BaseLocalDataSource({required this.databaseHelper});
  Future<Database> getDatabase() async {
    return await databaseHelper.database;
  }
}
