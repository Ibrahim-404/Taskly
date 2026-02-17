import 'package:sqflite/sqflite.dart';

class CategoryOfTask {
  static const String tableName = 'category_of_task';
  static const String id = 'id';
  static const String categoryName = 'category_name';

  Future<void> addANewCategory(Database db) async {
    await db.execute(Category());
  }

  static String Category() {
    return '''
      CREATE TABLE $tableName (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $categoryName TEXT NOT NULL
      )
    ''';
  }
}
