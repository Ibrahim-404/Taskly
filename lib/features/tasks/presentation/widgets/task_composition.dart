import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/add_new_category_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/category_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_search.dart';
import 'package:tasks_manager/core/const/strings.dart';

class TaskComposition extends StatefulWidget {
  TaskComposition({super.key});
  final TextEditingController controller = TextEditingController();
  final SearchController searchController = SearchController();
  final FocusNode focusNode = FocusNode();
  @override
  State<TaskComposition> createState() => _TaskCompositionState();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}

class _TaskCompositionState extends State<TaskComposition> {
  @override
  void initState() {
    taskController.fetchCategories();
    super.initState();
  }

  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearch(searchController: widget.searchController),
              SizedBox(
                height: 65,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: taskController.categories.length + 1,
                          itemBuilder: (context, index) {
                            final categories = taskController.categories;
                            if (index == categories.length) {
                              return AddNewCategoryWidget(
                                widget: widget,
                                taskController: taskController,
                              );
                            } else {
                              return CategoryWidget(
                                categoryName:
                                    categories[index]['category_name']
                                        as String? ??
                                    '${Strings.category} $index',
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
