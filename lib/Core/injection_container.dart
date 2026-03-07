import 'package:get/get.dart';
import 'package:tasks_manager/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';
import 'package:tasks_manager/features/Tasks/data/repo/task_repo_imp.dart';

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
    // repositories --> repositories depend on data sources 
Get.lazyPut<TaskRepoImp>(()=> TaskRepoImp(
       taskLocalDataSource: Get.find(),
    ));

    // use cases
 Get.lazyPut(() => AddTaskUseCase(Get.find()));
    Get.lazyPut(() => DeleteTaskUseCase(Get.find()));
    Get.lazyPut(() => UpdateTaskUseCase(Get.find()));
    Get.lazyPut(() => GetTasksUseCase(Get.find()));
    Get.lazyPut(() => GetTasksByCategoryUseCase(Get.find()));
    Get.lazyPut(() => AddCategoryUseCase(Get.find()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find()));
    // controllers
  }
}


    //external dependencies
    // data sources
    // repositories
    // use cases
    // controllers