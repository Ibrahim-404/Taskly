import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/category_management.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/choice_deadline.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/csutom_lottie_animation.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_button.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_text_form_field.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/dynamic_sub_task_section.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/show_category_list_as_drop_down.dart';
import 'package:tasks_manager/Core/const/strings.dart';

class CustomShowDialogForAddNewTask extends StatelessWidget {
  CustomShowDialogForAddNewTask({super.key});
  final AddtaskCategoryController addtaskCategoryController = Get.find();
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: addtaskCategoryController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    Strings.addNewTask,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CsutomLottieAnimation(),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: addtaskCategoryController.taskName,
                    hintText: Strings.title,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Strings.titleRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: addtaskCategoryController.taskDescription,
                    maxLines: 3,
                    hintText: Strings.description,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Strings.descriptionRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShowCategoryListAsDropDown(
                    taskController: taskController,
                    addtaskCategoryController: addtaskCategoryController,
                  ),
                  const SizedBox(height: 8),
                  ChoiceDeadline(
                    addtaskCategoryController: addtaskCategoryController,
                  ),
                  const SizedBox(height: 16),
                  DynamicSubTaskSection(taskController: taskController),
                  const SizedBox(height: 16),
                  CustomButton(
                    formKey: addtaskCategoryController.formKey,
                    taskController: taskController,
                    addtaskCategoryController: addtaskCategoryController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
