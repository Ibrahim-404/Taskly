import 'package:flutter/material.dart';

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
    final cs = Theme.of(context).colorScheme;
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
                Text(
                  'PROGRESS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                Text(
                  '$animatedPercentage%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: animatedProgress,
                backgroundColor: cs.surfaceContainerHighest,
                color: cs.primary,
                minHeight: 6,
              ),
            ),
          ],
        );
      },
    );
  }
}
