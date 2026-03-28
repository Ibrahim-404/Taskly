import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_task.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_task_by_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_tasks.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/sub_task_text_edit_controller_model.dart';

class TaskController extends BaseController {
  GetCategories getCategories;
  GetTasksByCategoryUseCase getTasksByCategoryUseCase;
  GetTasks getTasks;
  AddTask addTask;
  AddCategory addCategory;
  TaskController({
    required this.getCategories, //Done
    required this.getTasksByCategoryUseCase,
    required this.getTasks, //Done
    required this.addTask, //Done
    required this.addCategory, //Done
  });
  // tasks
  final isTasksLoading = false.obs;
  final taskErrorMessage = ''.obs;
  final tasks = <TaskEntity>[].obs;
  // categories
  final categories = <Map<String, dynamic>>[].obs;
  final isCategoriesLoading = false.obs;
  final categoryErrorMessage = ''.obs;

  Future<void> fetchTasks() async {
    final result = await getTasks();
    result.fold(
      (failure) => taskErrorMessage.value = failure.message,
      (tasks) => this.tasks.value = tasks,
    );
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    final result = await getCategories();
    result.fold(
      (failure) {
        categoryErrorMessage.value = failure.message;
        isCategoriesLoading.value = false;
      },
      (categories) {
        this.categories.value = categories;
        isCategoriesLoading.value = false;
      },
    );
  }

  Future<void> addANewTask(TaskEntity task) async {
    isTasksLoading.value = true;
    final result = await addTask(task);
    result.fold(
      (failure) => taskErrorMessage.value = failure.message,
      (_) => fetchTasks(),
    );
  }

  Future<void> addANewCategory(String category) async {
    isCategoriesLoading.value = true;
    final result = await addCategory(category);
    result.fold(
      (failure) => categoryErrorMessage.value = failure.message,
      (_) => fetchCategories(),
    );
  }

  Future<void> fetchTasksByCategory(String category) async {
    final result = await getTasksByCategoryUseCase(category);
    result.fold(
      (failure) => taskErrorMessage.value = failure.message,
      (tasks) => this.tasks.value = tasks,
    );
  }

  // --- Sub Tasks Management ---
  final subTasksList = <SubTaskTextEditControllerModel>[].obs;

  void addSubTask() {
    subTasksList.add(
      SubTaskTextEditControllerModel(
        subTaskTextEditingController: TextEditingController(),
        subTaskDescriptionTextEditingController: TextEditingController(),
      ),
    );
  }

  void removeSubTask(int index) {
    if (index >= 0 && index < subTasksList.length) {
      subTasksList[index].subTaskTextEditingController.dispose();
      subTasksList[index].subTaskDescriptionTextEditingController.dispose();
      subTasksList.removeAt(index);
    }
  }

  void clearSubTasks() {
    for (var subTask in subTasksList) {
      subTask.subTaskTextEditingController.dispose();
      subTask.subTaskDescriptionTextEditingController.dispose();
    }
    subTasksList.clear();
  }
}
