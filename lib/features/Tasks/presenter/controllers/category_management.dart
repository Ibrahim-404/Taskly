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
  final loadingState = false.obs;
  final taskErrorMessage = ''.obs;
  final taskName = TextEditingController();
  final taskDescription = TextEditingController();
  final SubTaskTextEditControllerModel subTaskTextEditControllerModel;
  final RxList<SubTaskTextEditControllerModel> subTasksList =
      <SubTaskTextEditControllerModel>[].obs;
  final subTasks = <Map<String, dynamic>>[].obs;
  final taskCategory = <Map<String, dynamic>>[].obs;
  final Rx<DateTime> selectedtime = DateTime.now().obs;
  final Rx<TimeOfDay> selectedDate = TimeOfDay.now().obs;
  final selectedCategoryId = ''.obs;

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
  }
}
