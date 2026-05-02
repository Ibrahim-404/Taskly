import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/core/const/app_colors.dart';

class TaskPrioritySelector extends StatelessWidget {
  final AddtaskCategoryController addtaskCategoryController;

  const TaskPrioritySelector({
    super.key,
    required this.addtaskCategoryController,
  });

  @override
  Widget build(BuildContext context) {
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

final List<Map<String, dynamic>> priorityLevels = [
  {"priority": TaskPriority.high, "label": "High", "color": AppColors.error},
  {
    "priority": TaskPriority.medium,
    "label": "Medium",
    "color": AppColors.warning,
  },
  {"priority": TaskPriority.low, "label": "Low", "color": AppColors.success},
];
