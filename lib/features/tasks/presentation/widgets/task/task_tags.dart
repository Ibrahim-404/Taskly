import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/add_task/task_priority_selector.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tag.dart';

class TaskTags extends StatelessWidget {
  final String categoryName;
  final String priority;
  final DateTime date;

  const TaskTags({
    super.key,
    required this.date,
    required this.categoryName,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        TaskTag(
          text: priority,
          bgColor: getColorMatchpriority(priority),
          textColor: AppColors.white,
        ),
        TaskTag(
          text: getTaskState(date).name,
          bgColor: AppColors.blue100,
          textColor: AppColors.blue700,
        ),
        TaskTag(
          text:
              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
          bgColor: AppColors.grey200,
          textColor: AppColors.black87,
          icon: Icons.calendar_today,
        ),
        TaskTag(
          text: categoryName,
          bgColor: AppColors.blue50,
          textColor: AppColors.blue700,
        ),
        // TaskTag(
        //   text: '#Important',
        //   bgColor: AppColors.orange50,
        //   textColor: AppColors.orange700,
        // ),
      ],
    );
  }
}

enum TaskState { ended, today, inProgress }

TaskState getTaskState(DateTime deadline) {
  final now = DateTime.now();
  if (deadline.isBefore(now)) {
    return TaskState.ended;
  }
  if (deadline.year == now.year &&
      deadline.month == now.month &&
      deadline.day == now.day) {
    return TaskState.today;
  } else {
    return TaskState.inProgress;
  }
}

Color getColorMatchpriority(String priority) {
  if (priority == "low") {
    return AppColors.success;
  } else if (priority == "medium") {
    return AppColors.warning;
  } else {
    return AppColors.error;
  }
}
