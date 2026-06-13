import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tag.dart';

class TaskTags extends StatelessWidget {
  final String categoryName;
  final String priority;
  final DateTime date;
  final bool isDone;

  const TaskTags({
    super.key,
    required this.date,
    required this.categoryName,
    required this.priority,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        TaskTag(
          text: priority,
          bgColor: getColorMatchpriority(priority, cs).withValues(alpha: 0.12),
          textColor: getColorMatchpriority(priority, cs),
        ),
        TaskTag(
          text: getTaskStateString(date, isDone),
          bgColor: cs.primaryContainer.withValues(alpha: 0.6),
          textColor: cs.onPrimaryContainer,
        ),
        TaskTag(
          text: _formatDate(date),
          bgColor: cs.surfaceContainerHighest.withValues(alpha: 0.6),
          textColor: cs.onSurfaceVariant,
          prefix: Icons.calendar_today_rounded,
        ),
        TaskTag(
          text: categoryName,
          bgColor: cs.secondaryContainer.withValues(alpha: 0.6),
          textColor: cs.onSecondaryContainer,
          prefix: Icons.folder_rounded,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

String getTaskStateString(DateTime deadline, bool isDone) {
  if (isDone) return 'Done';
  final now = DateTime.now();
  if (deadline.isBefore(now)) return 'Overdue';
  if (deadline.year == now.year &&
      deadline.month == now.month &&
      deadline.day == now.day) {
    return 'Today';
  }
  return 'Upcoming';
}

Color getColorMatchpriority(String priority, ColorScheme cs) {
  switch (priority) {
    case 'high':
      return cs.error;
    case 'medium':
      return Colors.orange;
    default:
      return Colors.green;
  }
}
