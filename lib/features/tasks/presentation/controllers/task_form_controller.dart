import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/add_task.dart';
import 'package:tasks_manager/features/tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/sub_task_text_edit_controller_model.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class TaskFormController extends BaseController {
  final AddTask addTask;
  final GetCategories getCategories;

  TaskFormController({required this.addTask, required this.getCategories});

  final taskName = TextEditingController();
  final taskDescription = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final subTasksList = <SubTaskTextEditControllerModel>[].obs;
  final categories = <Map<String, dynamic>>[].obs;

  final selectedCategory = 0.obs;
  final priorityStatus = TaskPriority.low.obs;
  final selectedDeadline = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();

  final isDatePicked = false.obs;
  final isTimePicked = false.obs;
  final isLoading = false.obs;
  final formErrorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final result = await getCategories();
    result.fold(
      (failure) => formErrorMessage.value = failure.toString(),
      (cats) => categories.value = cats,
    );
  }

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

  void setSelectedCategory(int categoryId) {
    selectedCategory.value = categoryId;
  }

  void setSelectedDeadline(DateTime date) {
    selectedDeadline.value = date;
    isDatePicked.value = true;
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime.value = time;
    isTimePicked.value = true;
  }

  Future<void> submitTask() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedCategory.value == 0) {
      formErrorMessage.value = 'Please select a category';
      return;
    }

    isLoading.value = true;

    final task = TaskEntity(
      id: 0,
      title: taskName.text,
      description: taskDescription.text,
      date: selectedDeadline.value ?? DateTime.now(),
      isDone: false,
      categoryId: selectedCategory.value,
      priorityStatus: priorityStatus.value,
      subTasks: subTasksList
          .map(
            (e) => SubTaskEntity(
              id: 0,
              title: e.subTaskTextEditingController.text,
              description: e.subTaskDescriptionTextEditingController.text,
              isDone: false,
              taskId: 0,
            ),
          )
          .toList(),
    );

    final result = await addTask(task);
    result.fold((failure) => formErrorMessage.value = failure.toString(), (_) {
      clearAll();
      Get.find<TaskController>().fetchTasks();
      Get.back();
    });

    isLoading.value = false;
  }

  void clearAll() {
    taskName.clear();
    taskDescription.clear();
    selectedCategory.value = 0;
    selectedDeadline.value = null;
    selectedTime.value = null;
    isDatePicked.value = false;
    isTimePicked.value = false;
    priorityStatus.value = TaskPriority.low;
    for (var subTask in subTasksList) {
      subTask.subTaskTextEditingController.dispose();
      subTask.subTaskDescriptionTextEditingController.dispose();
    }
    subTasksList.clear();
    formErrorMessage.value = '';
  }

  @override
  void onClose() {
    taskName.dispose();
    taskDescription.dispose();
    for (var subTask in subTasksList) {
      subTask.subTaskTextEditingController.dispose();
      subTask.subTaskDescriptionTextEditingController.dispose();
    }
    super.onClose();
  }
}
