import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tasks_manager/core/controller/theme_controller.dart';
import 'package:tasks_manager/core/database/database_helper.dart';
import 'package:tasks_manager/features/analysis/presentation/controllers/analytics_controller.dart';
import 'package:tasks_manager/features/tasks/data/datasource/locelDataSources/task_local_data_source.dart';
import 'package:tasks_manager/features/tasks/data/repo/task_repo_imp.dart';
import 'package:tasks_manager/features/tasks/domain/repo/task_repo.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/complete_sub_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/complete_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_category_name_By_Id.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_form_controller.dart';

import '../features/tasks/data/datasource/locelDataSources/task_local_data_source_imp.dart';
import '../features/tasks/domain/usecases/add_category.dart';
import '../features/tasks/domain/usecases/add_task.dart';
import '../features/tasks/domain/usecases/delete_task.dart';
import '../features/tasks/domain/usecases/get_categories.dart';
import '../features/tasks/domain/usecases/get_task_by_category.dart';
import '../features/tasks/domain/usecases/get_tasks.dart';
import '../features/tasks/domain/usecases/update_task.dart';
import '../features/tasks/domain/usecases/get_upcoming_tasks.dart';
import 'notification/notfication.dart';
import 'notification/task_notification_scheduler.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    // external dependencies
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper(), fenix: true);
    Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
    Get.lazyPut<TaskNotificationScheduler>(
      () => TaskNotificationScheduler(
        notificationService: Get.find<NotificationService>(),
        getUpcomingTasks: Get.find<GetUpcomingTasks>(),
      ),
      fenix: true,
    );

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
    Get.lazyPut<CompleteSubTask>(
      () => CompleteSubTask(Get.find()),
      fenix: true,
    );
    Get.lazyPut<CompleteTask>(() => CompleteTask(Get.find()), fenix: true);
    Get.lazyPut<GetTasksByCategoryUseCase>(
      () => GetTasksByCategoryUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetTasks>(() => GetTasks(Get.find()), fenix: true);
    Get.lazyPut<GetUpcomingTasks>(
      () => GetUpcomingTasks(Get.find()),
      fenix: true,
    );
    Get.lazyPut<UpdateTask>(() => UpdateTask(Get.find()), fenix: true);
    Get.lazyPut<GetCategoryNameById>(
      () => GetCategoryNameById(Get.find()),
      fenix: true,
    );

    // controllers
    Get.lazyPut<TaskController>(
      () => TaskController(
        getTasks: Get.find<GetTasks>(),
        getTasksByCategoryUseCase: Get.find<GetTasksByCategoryUseCase>(),
        completeSubTask: Get.find<CompleteSubTask>(),
        completeTask: Get.find<CompleteTask>(),
        deleteTask: Get.find<DeleteTask>(),
        getCategories: Get.find<GetCategories>(),
        addCategory: Get.find<AddCategory>(),
      ),
      fenix: true,
    );

    Get.lazyPut<TaskFormController>(
      () => TaskFormController(
        addTask: Get.find<AddTask>(),
        getCategories: Get.find<GetCategories>(),
      ),
      fenix: true,
    );

    Get.lazyPut<AnalyticsController>(() => AnalyticsController(), fenix: true);
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
  }
}

//external dependencies
// data sources
// repositories
// use cases
// controllers
//addtaskCategoryController
