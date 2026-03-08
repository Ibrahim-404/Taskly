import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_task.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_task_by_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_tasks.dart';

class TaskController extends GetxController {
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
  final categories = <String>[].obs;
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
    final result = await getCategories();
    result.fold(
      (failure) => categoryErrorMessage.value = failure.message,
      (categories) => this.categories.value = categories,
    );
  }

  Future<void> addANewTask(TaskEntity task) async {
    final result = await addTask(task);
    result.fold(
      (failure) => taskErrorMessage.value = failure.message,
      (_) => fetchTasks(),
    );
  }

  Future<void> addANewCategory(String category) async {
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
}
