import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';

class TaskSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const TaskSectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
