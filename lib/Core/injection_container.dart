import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tasks_manager/Core/database/database_helper.dart';
import 'package:tasks_manager/features/Tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/Tasks/data/repo/task_repo_imp.dart';
import 'package:tasks_manager/features/Tasks/domain/repo/task_repo.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/category_management.dart';

import '../features/Tasks/data/datasource/locelDataSources/task_local_data_source_imp.dart';
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
    // external dependencies
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper(), fenix: true);

    // data sources
    Get.lazyPut<TaskLocalDataSource>(
      () => TaskLocalDataSourceImp(databaseHelper: Get.find<DatabaseHelper>()),
      fenix: true,
    );

    // repositories --> repositories depend on data sources
    Get.lazyPut<TaskRepo>(
      () => TaskRepoImp(taskLocalDataSource: Get.find()),
      fenix: true,
    );

    // use cases
    Get.lazyPut<AddCategory>(() => AddCategory(Get.find()), fenix: true);
    Get.lazyPut<AddTask>(() => AddTask(Get.find()), fenix: true);
    Get.lazyPut<DeleteTask>(() => DeleteTask(Get.find()), fenix: true);
    Get.lazyPut<GetCategories>(() => GetCategories(Get.find()), fenix: true);
    Get.lazyPut<GetTasksByCategoryUseCase>(
      () => GetTasksByCategoryUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetTasks>(() => GetTasks(Get.find()), fenix: true);
    Get.lazyPut<UpdateTask>(() => UpdateTask(Get.find()), fenix: true);

    // controllers
    Get.lazyPut<TaskController>(
      () => TaskController(
        getCategories: Get.find(),
        getTasksByCategoryUseCase: Get.find(),
        getTasks: Get.find(),
        addTask: Get.find(),
        addCategory: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<AddtaskCategoryController>(
      () => AddtaskCategoryController(
        Get.find(),
        getCategories: Get.find(),
        addTask: Get.find(),
      ),
      fenix: true,
    );
  }
}

//external dependencies
// data sources
// repositories
// use cases
// controllers
