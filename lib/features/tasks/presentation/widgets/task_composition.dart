import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/add_new_category_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/category_widget.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class TaskComposition extends StatefulWidget {
  final bool onlyForSearch;

  const TaskComposition({super.key, this.onlyForSearch = false});

  @override
  State<TaskComposition> createState() => _TaskCompositionState();
}

class _TaskCompositionState extends State<TaskComposition> {
  final TaskController taskController = Get.find();
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? selectedCategoryIndex;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskController.categories.length + 2,
                    itemBuilder: (context, index) {
                      final categories = taskController.categories;
                      if (index == 0) {
                        return CategoryWidget(
                          categoryName: 'All',
                          isSelected: selectedCategoryIndex == null,
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = null;
                            });
                            taskController.fetchTasks();
                          },
                        );
                      }

                      if (index == categories.length + 1) {
                        return AddNewCategoryWidget(
                          controller: controller,
                          formKey: formKey,
                          taskController: taskController,
                        );
                      }

                      final categoryIndex = index - 1;
                      final categoryName =
                          categories[categoryIndex]['category_name']
                              as String? ??
                          '${AppLocalizations.of(context)!.category} $categoryIndex';
                      return CategoryWidget(
                        categoryName: categoryName,
                        isSelected: selectedCategoryIndex == categoryIndex,
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = categoryIndex;
                          });
                          if (categoryName == 'All') {
                            selectedCategoryIndex == 0
                                ? taskController.selectedCategory.value = "All"
                                : null;
                          }
                          taskController.selectedCategory.value = categoryName;
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
