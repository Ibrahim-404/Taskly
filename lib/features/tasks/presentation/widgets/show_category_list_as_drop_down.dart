import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/core/const/strings.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: const Color(0xFF6A11CB).withOpacity(0.5),
                width: 1.5,
              ),
            ),
          ),
          isExpanded: true,
          hint: const Text(
            Strings.select,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF6A11CB),
          ),
          items: taskController.categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat['id'].toString(),
              child: Text(
                cat['category_name'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
    );
  }
}
