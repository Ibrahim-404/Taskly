import 'package:get_it/get_it.dart';
import 'package:tasks_manager/features/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/features/Core/database/database_helper.dart';
import 'package:tasks_manager/features/Tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/Tasks/data/datasource/locelDataSources/task_local_data_source_imp.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  sl.registerLazySingleton<BaseLocalDataSource>(
    () => BaseLocalDataSource(databaseHelper: sl()),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImp(databaseHelper: sl()),
  );
}
