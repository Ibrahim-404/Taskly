import 'package:get/get.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';
import 'package:tasks_manager/Core/enums/view_state.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_task.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_task_by_category.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_tasks.dart';

class TaskController extends BaseController {
  GetCategories getCategories;
  GetTasksByCategoryUseCase getTasksByCategoryUseCase;
  GetTasks getTasks;
  AddTask addTask;
  AddCategory addCategory;
  TaskController({
    required this.getCategories, //Done
    required this.getTasksByCategoryUseCase, //Done
    required this.getTasks, //Done
    required this.addTask, //Done
    required this.addCategory, //Done
  });
  // tasks
  // final isTasksLoading = false.obs;
  // final errorMessage = ''.obs;
  final tasks = <TaskEntity>[].obs;
  // categories
  final categories = <String>[].obs;
  final isCategoriesLoading = false.obs;
  final categoryErrorMessage = ''.obs;
  Future<void> fetchTasks() async {
    setState(ViewState.busy);
    final result = await getTasks();
    result.fold(
      (failure) => setState(ViewState.error, errorMessage: failure.message),
      (tasks) => this.tasks.value = tasks,
    );
  }

  Future<void> fetchCategories() async {
    setState(ViewState.busy);
    final result = await getCategories();
    result.fold(
      (failure) => setState(ViewState.error, errorMessage: failure.message),
      (categories) => this.categories.value = categories,
    );
  }

  Future<void> addANewTask(TaskEntity task) async {
    setState(ViewState.busy);
    final result = await addTask(task);
    result.fold(
      (failure) => setState(ViewState.error, errorMessage: failure.message),
      (_) => fetchTasks(),
    );
  }

  Future<void> addANewCategory(String category) async {
    setState(ViewState.busy);
    final result = await addCategory(category);
    result.fold(
      (failure) => setState(ViewState.error, errorMessage: failure.message),
      (_) => fetchCategories(),
    );
  }

  Future<void> fetchTasksByCategory(String category) async {
    setState(ViewState.busy);
    final result = await getTasksByCategoryUseCase(category);
    result.fold(
      (failure) => setState(ViewState.error, errorMessage: failure.message),
      (tasks) => this.tasks.value = tasks,
    );
  }
}
