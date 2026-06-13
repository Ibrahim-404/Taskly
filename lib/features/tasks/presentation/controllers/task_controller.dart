import 'dart:developer';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/core/enums/task_filter.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';
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
  final selectedCategory = RxnString();

  // Search & filter state
  final searchQuery = RxnString();
  final activeFilter = TaskFilter.all.obs;
  final displayedTasks = <TaskEntity>[].obs;

  void scrollToTask(String taskId) {
    rxScrollToTaskId.value = taskId;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    fetchCategories();

    debounce<String?>(
      searchQuery,
      (_) => _applyFilters(),
      time: const Duration(milliseconds: 600),
    );
  }


  void setSearchQuery(String query) {
    if (query.isEmpty) {
      searchQuery.value = null;
      _applyFilters();
    } else {
      searchQuery.value = query;
    }
  }

  void setFilter(TaskFilter filter) {
    activeFilter.value = filter;
    _applyFilters();
  }

  void _applyFilters() {
    var result = List<TaskEntity>.from(tasks);

    final query = searchQuery.value;
    if (query != null && query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      result = result.where((t) =>
        t.title.toLowerCase().contains(lowerQuery) ||
        t.description.toLowerCase().contains(lowerQuery)
      ).toList();
    }

    switch (activeFilter.value) {
      case TaskFilter.all:
        break;
      case TaskFilter.completed:
        result = result.where((t) => t.isDone).toList();
        break;
      case TaskFilter.inProgress:
        result = result.where((t) => !t.isDone).toList();
        break;
      case TaskFilter.highPriority:
        result = result.where((t) => t.priorityStatus == TaskPriority.high).toList();
        break;
      case TaskFilter.dueSoon:
        result = result.where((t) => !t.isDone && _isDueSoon(t.date)).toList();
        break;
      case TaskFilter.overdue:
        result = result.where((t) => t.isMissed).toList();
        break;
    }

    displayedTasks.value = result;
  }

  bool _isDueSoon(DateTime date) {
    final now = DateTime.now();
    final threeDays = now.add(const Duration(days: 3));
    return date.isAfter(now) && date.isBefore(threeDays);
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

  Future<void> fetchTasks({bool forceRefresh = false}) async {
  if (tasks.isNotEmpty && !forceRefresh) return;

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
  _applyFilters();
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

  Future<List<TaskEntity>> fetchTasksByCategory(String category) async {
    isTasksLoading.value = true;
    taskErrorMessage.value = '';
    List<TaskEntity> fetched = [];
    final result = await getTasksByCategoryUseCase(category);
    result.fold(
      (failure) => taskErrorMessage.value = failure.toString(),
      (tasksList) => fetched = tasksList,
    );
    tasks.value = fetched;
    if (tasks.isEmpty) {
      taskErrorMessage.value = 'No tasks found for this category.';
      log("No tasks found for this category.");
    }
    isTasksLoading.value = false;
    _applyFilters();
    return fetched;
  }
}
