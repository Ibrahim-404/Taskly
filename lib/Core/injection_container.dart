import 'package:get/get.dart';
import 'package:tasks_manager/Core/database/base_locel_data_sources.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';
import 'package:tasks_manager/features/Tasks/data/repo/task_repo_imp.dart';

import '../features/Tasks/domain/usecases/add_category.dart';
import '../features/Tasks/domain/usecases/add_task.dart';
import '../features/Tasks/domain/usecases/delete_task.dart';
import '../features/Tasks/domain/usecases/get_categories.dart';
import '../features/Tasks/domain/usecases/get_task_by_category.dart';
import '../features/Tasks/domain/usecases/get_tasks.dart';
import '../features/Tasks/domain/usecases/update_task.dart';
import '../features/Tasks/presenter/controllers/task_controller.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    //external dependencies
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper());

    // data sources
    Get.lazyPut<BaseLocalDataSource>(
      () => BaseLocalDataSource(databaseHelper: Get.find<DatabaseHelper>()),
    );
    // repositories --> repositories depend on data sources
    Get.lazyPut<TaskRepoImp>(
      () => TaskRepoImp(taskLocalDataSource: Get.find()),
    );

    // use cases
    Get.lazyPut<AddCategory>(() => AddCategory(Get.find()));
    Get.lazyPut<AddTask>(() => AddTask(Get.find()));
    Get.lazyPut<DeleteTask>(() => DeleteTask(Get.find()));
    Get.lazyPut<GetCategories>(() => GetCategories(Get.find()));
    Get.lazyPut<GetTasksByCategoryUseCase>(
      () => GetTasksByCategoryUseCase(Get.find()),
    );
    Get.lazyPut<GetTasks>(() => GetTasks(Get.find()));
    Get.lazyPut<UpdateTask>(() => UpdateTask(Get.find()));

    // controllers
    Get.lazyPut<TaskController>(()=>TaskController(
      getCategories: Get.find(),
      getTasksByCategoryUseCase: Get.find(),
      getTasks: Get.find(),
      addTask: Get.find(),
      addCategory: Get.find(),
    ));
  }
}

//external dependencies
// data sources
// repositories
// use cases
// controllers
