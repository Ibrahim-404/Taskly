import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/choice_deadline.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_button.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_text_form_field.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/dynamic_sub_task_section.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/category_widget.dart';
import 'package:tasks_manager/core/const/strings.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/show_category_list_as_drop_down.dart';

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
          const Center(
            child: Text(
              Strings.addNewTask,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A1A),
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
                    _buildSectionTitle(Icons.title_rounded, Strings.title),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 24),
                    _buildSectionTitle(
                      Icons.description_rounded,
                      Strings.description,
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
                    const SizedBox(height: 24),
                    _buildSectionTitle(
                      Icons.calendar_today_rounded,
                      "Deadline",
                    ),
                    const SizedBox(height: 8),
                    ChoiceDeadline(
                      addtaskCategoryController: addtaskCategoryController,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(
                      Icons.category_rounded,
                      "choose Category",
                    ),
                    const SizedBox(height: 8),
                    ShowCategoryListAsDropDown(
                      addtaskCategoryController: addtaskCategoryController,
                      taskController: taskController,
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      Icons.calendar_today_rounded,
                      "priority",
                    ),
                    const SizedBox(height: 8),
                    _choicesPriority(addtaskCategoryController),
                    const SizedBox(height: 24),
                    _buildSectionTitle(Icons.list_alt_rounded, "Sub Tasks"),
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

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6A11CB)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A4A4A),
          ),
        ),
      ],
    );
  }

  Widget _choicesPriority(AddtaskCategoryController addtaskCategoryController) {
    return Obx(
      () => Row(
        children: List.generate(priorityLevels.length, (index) {
          final priority = priorityLevels[index]['priority'] as TaskPriority;
          final label = priorityLevels[index]['label'] as String;
          final color = priorityLevels[index]['color'] as Color;
          final isSelected =
              addtaskCategoryController.priorityStatus.value == priority;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                addtaskCategoryController.priorityStatus.value = priority;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(color: color, width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

List<Map<String, dynamic>> priorityLevels = [
  {"priority": TaskPriority.high, "label": "High", "color": Colors.red},
  {"priority": TaskPriority.medium, "label": "Medium", "color": Colors.orange},
  {"priority": TaskPriority.low, "label": "Low", "color": Colors.green},
];
