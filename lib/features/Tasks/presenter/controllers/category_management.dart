import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';
import 'package:tasks_manager/features/Tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/add_task.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/sub_task_text_edit_controller_model.dart';

class AddtaskCategoryController extends BaseController {
  final GetCategories getCategories;
  final AddTask addTask;
  AddtaskCategoryController(
    this.subTaskTextEditControllerModel, {
    required this.getCategories,
    required this.addTask,
  });
  final SubTaskTextEditControllerModel subTaskTextEditControllerModel;
  final loadingState = false.obs;
  final taskErrorMessage = ''.obs;
  final taskName = TextEditingController();
  final taskDescription = TextEditingController();
  final RxList<SubTaskTextEditControllerModel> subTasksList =
      <SubTaskTextEditControllerModel>[].obs;
  final subTasks = <Map<String, dynamic>>[].obs;
  final taskCategory = <Map<String, dynamic>>[].obs;
  final Rxn<DateTime> selectedDeadline = Rxn<DateTime>();
  final Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  final selectedCategory = 0.obs;
  final isDatePicked = false.obs;
  final isTimePicked = false.obs;
  final formKey = GlobalKey<FormState>();
  final pickCategoryId = 0.obs;

  Future<void> fetchCategories() async {
    loadingState.value = true;
    final result = await getCategories();
    result.fold(
      (failure) {
        taskErrorMessage.value = failure.message;
        loadingState.value = false;
      },
      (categories) {
        this.taskCategory.value = categories;
        loadingState.value = false;
      },
    );
  }

  Future<void> addNewSubTask() async {
    subTasksList.add(
      SubTaskTextEditControllerModel(
        subTaskTextEditingController: TextEditingController(),
        subTaskDescriptionTextEditingController: TextEditingController(),
      ),
    );
  }

  Future<void> addANewTask(TaskEntity task) async {
    loadingState.value = true;
    final result = await addTask(task);
    result.fold(
      (failure) => taskErrorMessage.value = failure.message,
      (r) => (),
    );
    loadingState.value = false;
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

  void clearAll() {
    taskName.clear();
    taskDescription.clear();
    selectedCategory.value = 0;
    selectedDeadline.value = null;
    selectedTime.value = null;
    isDatePicked.value = false;
    isTimePicked.value = false;
  }
}
