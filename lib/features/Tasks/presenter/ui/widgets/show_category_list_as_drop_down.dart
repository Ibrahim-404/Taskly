import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/category_management.dart';
import 'package:tasks_manager/Core/const/strings.dart';

class ShowCategoryListAsDropDown extends StatelessWidget {
  final TaskController taskController;
  final AddtaskCategoryController addtaskCategoryController;
  const ShowCategoryListAsDropDown({
    super.key,
    required this.taskController,
    required this.addtaskCategoryController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text(Strings.category)),
        Expanded(
          child: Obx(
            () => DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.blue.shade300,
                    width: 1.5,
                  ),
                ),
              ),
              isExpanded: true,
              hint: const Text(Strings.select),
              items: taskController.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat['id'].toString(),
                  child: Text(cat['category_name'].toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  final categoryId = int.parse(value);
                  print("category id : $categoryId");
                  addtaskCategoryController.pickCategoryId.value = categoryId;
                  addtaskCategoryController.setSelectedCategory(categoryId);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
