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
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: progress),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, child) {
        final animatedPercentage = (animatedProgress * 100).toInt();
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
                  '$animatedPercentage%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: animatedProgress,
                backgroundColor: AppColors.grey200,
                color: AppColors.blue700,
                minHeight: 6,
              ),
            ),
          ],
        );
      },
    );
  }
}
