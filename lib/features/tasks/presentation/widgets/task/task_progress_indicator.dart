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
                  'Progress',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                Text(
                  '$animatedPercentage%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: animatedProgress,
                backgroundColor: cs.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                minHeight: 4,
              ),
            ),
          ],
        );
      },
    );
  }
}
