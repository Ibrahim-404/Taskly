import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/choice_deadline.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_button.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_text_form_field.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/dynamic_sub_task_section.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/category_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/show_category_list_as_drop_down.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/add_task/task_priority_selector.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/add_task/task_section_title.dart';
import 'package:tasks_manager/core/utils/app_validators.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class CustomShowDialogForAddNewTask extends StatelessWidget {
  const CustomShowDialogForAddNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final AddtaskCategoryController addtaskCategoryController = Get.find();
    final TaskController taskController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taskController.categories.length,
                itemBuilder: (context, index) {
                  final category = taskController.categories[index];
                  final categoryId = category['id'] as int;
                  return Obx(
                    () => CategoryWidget(
                      categoryName: category['category_name'] as String,
                      isSelected:
                          addtaskCategoryController.selectedCategory.value ==
                          categoryId,
                      onTap: () {
                        addtaskCategoryController.setSelectedCategory(
                          categoryId,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              AppLocalizations.of(context)!.addNewTask,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: addtaskCategoryController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskSectionTitle(
                      icon: Icons.title_rounded,
                      title: AppLocalizations.of(context)!.title,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: addtaskCategoryController.taskName,
                      hintText: AppLocalizations.of(context)!.title,
                      validator: (value) => AppValidators.requiredField(context, value, AppLocalizations.of(context)!.titleRequired),
                    ),
                    const SizedBox(height: 24),
                    TaskSectionTitle(
                      icon: Icons.description_rounded,
                      title: AppLocalizations.of(context)!.description,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: addtaskCategoryController.taskDescription,
                      maxLines: 3,
                      hintText: AppLocalizations.of(context)!.description,
                      validator: (value) => AppValidators.requiredField(context, value, AppLocalizations.of(context)!.descriptionRequired),
                    ),
                    const SizedBox(height: 24),
                    const TaskSectionTitle(
                      icon: Icons.calendar_today_rounded,
                      title: "Deadline",
                    ),
                    const SizedBox(height: 8),
                    ChoiceDeadline(
                      addtaskCategoryController: addtaskCategoryController,
                    ),
                    const SizedBox(height: 24),
                    const TaskSectionTitle(
                      icon: Icons.category_rounded,
                      title: "choose Category",
                    ),
                    const SizedBox(height: 8),
                    ShowCategoryListAsDropDown(
                      addtaskCategoryController: addtaskCategoryController,
                      taskController: taskController,
                    ),

                    const SizedBox(height: 24),

                    const TaskSectionTitle(
                      icon: Icons.calendar_today_rounded,
                      title: "priority",
                    ),
                    const SizedBox(height: 8),
                    TaskPrioritySelector(
                      addtaskCategoryController: addtaskCategoryController,
                    ),
                    const SizedBox(height: 24),
                    const TaskSectionTitle(
                      icon: Icons.list_alt_rounded,
                      title: "Sub Tasks",
                    ),
                    const SizedBox(height: 8),
                    DynamicSubTaskSection(taskController: taskController),
                    const SizedBox(height: 40),
                    CustomButton(
                      formKey: addtaskCategoryController.formKey,
                      taskController: taskController,
                      addtaskCategoryController: addtaskCategoryController,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
