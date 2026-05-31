import 'dart:developer';

import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/complete_sub_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/complete_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_task_by_category.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_tasks.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/delete_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/add_category.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_form_controller.dart';

class TaskController extends BaseController {
  final GetTasks getTasks;
  final GetTasksByCategoryUseCase getTasksByCategoryUseCase;
  final CompleteSubTask completeSubTask;
  final CompleteTask completeTask;
  final DeleteTask deleteTask;
  final GetCategories getCategories;
  final AddCategory addCategory;

  TaskController({
    required this.getTasks,
    required this.getTasksByCategoryUseCase,
    required this.completeSubTask,
    required this.completeTask,
    required this.deleteTask,
    required this.getCategories,
    required this.addCategory,
  });

  // Global state
  final tasks = <TaskEntity>[].obs;
  final categories = <Map<String, dynamic>>[].obs;
  final isTasksLoading = false.obs;
  final taskErrorMessage = ''.obs;
  final rxScrollToTaskId = RxnString();

  void scrollToTask(String taskId) {
    rxScrollToTaskId.value = taskId;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    fetchCategories();
  }

  // Computed properties for filtering tasks
  List<TaskEntity> get missedTasks {
    return tasks.where((task) => task.isMissed).toList();
  }

  List<TaskEntity> get completedTasks {
    return tasks.where((task) => task.isDone).toList();
  }

  List<TaskEntity> get upcomingTasks {
    return tasks.where((task) => task.isUpcoming).toList();
  }

  Future<void> fetchCategories() async {
    final result = await getCategories();
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (cats) => categories.value = cats,
    );
  }

  void addANewCategory(String categoryName) async {
    final result = await addCategory(categoryName);
    result.fold((failure) => taskErrorMessage.value = failure.toString(), (_) {
      fetchCategories();
      // Also refresh the task form categories if it's currently initialized
      if (Get.isRegistered<TaskFormController>()) {
        Get.find<TaskFormController>().fetchCategories();
      }
    });
  }

  Future<void> fetchTasks() async {
    isTasksLoading.value = true;
    taskErrorMessage.value = '';
    final result = await getTasks();
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (tasksList) => tasks.value = tasksList,
    );
    if (tasks.isEmpty) {
      taskErrorMessage.value = 'No tasks found. Please add some tasks.';
      log("No tasks found. Please add some tasks.");
    }
    isTasksLoading.value = false;
  }

  void completeSubTaskFun({
    required String subTaskId,
    required bool taskState,
  }) async {
    final result = await completeSubTask(subTaskId, taskState);
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (_) => fetchTasks(),
    );
  }

  void completeTaskFun({required String taskId}) async {
    final result = await completeTask(taskId);
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (_) => fetchTasks(),
    );
  }

  void deleteTaskFun(int taskId) async {
    final result = await deleteTask(taskId);
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (_) => fetchTasks(),
    );
  }
}
