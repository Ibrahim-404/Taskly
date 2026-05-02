import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tag.dart';

class TaskTags extends StatelessWidget {
  final DateTime date;

  const TaskTags({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        TaskTag(text: 'HIGH', bgColor: AppColors.error, textColor: AppColors.white),
        TaskTag(text: 'IN PROGRESS', bgColor: AppColors.blue100, textColor: AppColors.blue700),
        TaskTag(
          text: "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
          bgColor: AppColors.grey200,
          textColor: AppColors.black87,
          icon: Icons.calendar_today,
        ),
        TaskTag(text: '#Work', bgColor: AppColors.blue50, textColor: AppColors.blue700),
        TaskTag(text: '#Important', bgColor: AppColors.orange50, textColor: AppColors.orange700),
      ],
    );
  }
}
