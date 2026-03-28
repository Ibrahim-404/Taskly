import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/choice_deadline.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/csutom_lottie_animation.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_button.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_text_form_field.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/dynamic_sub_task_section.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/show_category_list_as_drop_down.dart';
import 'package:tasks_manager/Core/strings.dart';

class CustomShowDialogForAddNewTask extends StatelessWidget {
  final TaskController taskController;
  final TextEditingController titleController;
  final TextEditingController mainDescriptionController;

  const CustomShowDialogForAddNewTask({
    required this.taskController,
    required this.titleController,
    required this.mainDescriptionController,
    super.key,
  });

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    Strings.addNewTask,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CsutomLottieAnimation(),
                  const SizedBox(height: 16),
                  CustomTextFormField(controller: titleController),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: mainDescriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ShowCategoryListAsDropDown(taskController: taskController),
                  const SizedBox(height: 8),
                  ChoiceDeadline(addtaskCategoryController: Get.find()),
                  const SizedBox(height: 16),
                  DynamicSubTaskSection(taskController: taskController),
                  const SizedBox(height: 16),
                  CustomButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
