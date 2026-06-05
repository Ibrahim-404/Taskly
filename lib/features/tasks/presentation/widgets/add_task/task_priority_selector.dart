import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/enums/priority_enum.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_form_controller.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/core/const/app_strings.dart';

class TaskPrioritySelector extends StatelessWidget {
  final TaskFormController taskFormController;

  const TaskPrioritySelector({super.key, required this.taskFormController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(priorityLevels.length, (index) {
          final priority = priorityLevels[index]['priority'] as TaskPriority;
          final label = priorityLevels[index]['label'] as String;
          final color = priorityLevels[index]['color'] as Color;
          final isSelected =
              taskFormController.priorityStatus.value == priority;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                taskFormController.priorityStatus.value = priority;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
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
  {
    "priority": TaskPriority.high,
    "label": AppStrings.high,
    "color": AppColors.error,
  },
  {
    "priority": TaskPriority.medium,
    "label": AppStrings.medium,
    "color": AppColors.warning,
  },
  {
    "priority": TaskPriority.low,
    "label": AppStrings.low,
    "color": AppColors.success,
  },
];
