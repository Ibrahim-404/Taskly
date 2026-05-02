import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';

class TaskProgressIndicator extends StatelessWidget {
  final int progressPercentage;
  final double progress;

  const TaskProgressIndicator({
    super.key,
    required this.progressPercentage,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'PROGRESS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
            Text(
              '$progressPercentage%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.grey200,
          color: AppColors.blue700,
          minHeight: 6,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
