import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';
import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';

class AddtaskCategoryController extends BaseController {
  GetCategories getCategories;
  AddtaskCategoryController({required this.getCategories});
  final LoadingState = false.obs;
  final taskErrorMessage = ''.obs;
  final taskName = TextEditingController();
  final taskDescription = TextEditingController();
  final subTaskTitle = TextEditingController();
  final subtaskDescription = TextEditingController();

  final subTasks = <Map<String, dynamic>>[].obs;
  final taskCategory = <Map<String, dynamic>>[].obs;

  Future<void> fetchCategories() async {
    LoadingState.value = true;
    final result = await getCategories();
    result.fold(
      (failure) {
        taskErrorMessage.value = failure.message;
        LoadingState.value = false;
      },
      (categories) {
        this.taskCategory.value = categories;
        LoadingState.value = false;
      },
    );
  }
  





}
