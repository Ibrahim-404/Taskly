import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:tasks_manager/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';


class Taskbinding extends Bindings {
  @override
  void dependencies() {
    // core & database(dataSources)
Get.lazyPut<DatabaseHelper>(() => DatabaseHelper(),fenix: true);
 Get.lazyPut<BaseLocalDataSource>(
    () => BaseLocalDataSource(databaseHelper: Get.find()),fenix: true,
  );
  // repo

  // useCase
  }
}
