import 'package:get/get.dart';
import 'package:tasks_manager/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    //external dependencies
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper());

    // data sources
  Get.lazyPut<BaseLocalDataSource>(
      () => BaseLocalDataSource(
        databaseHelper: Get.find<DatabaseHelper>(),
      ),
    );
    // repositories

    // use cases

    // controllers
  }
}


    //external dependencies
    // data sources
    // repositories
    // use cases
    // controllers