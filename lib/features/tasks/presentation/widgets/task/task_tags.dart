import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
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
      spacing: 8,
      runSpacing: 8,
      children: [
        TaskTag(
          text: priority,
          bgColor: getColorMatchpriority(priority),
          textColor: cs.onPrimary,
        ),
        TaskTag(
          text: getTaskState(date, isDone).name,
          bgColor: cs.primaryContainer,
          textColor: cs.onPrimaryContainer,
        ),
        TaskTag(
          text:
              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
          bgColor: cs.surfaceContainerHighest,
          textColor: cs.onSurface,
          icon: Icons.calendar_today,
        ),
        TaskTag(
          text: categoryName,
          bgColor: cs.secondaryContainer,
          textColor: cs.onSecondaryContainer,
        ),
      ],
    );
  }
}

enum TaskState { ended, today, inProgress, done }

TaskState getTaskState(DateTime deadline, bool isDone) {
  final now = DateTime.now();
  if (deadline.isBefore(now)) {
    return TaskState.ended;
  }
  if (deadline.year == now.year &&
      deadline.month == now.month &&
      deadline.day == now.day) {
    return TaskState.today;
  } else if (isDone == true) {
    return TaskState.done;
  } else {
    return TaskState.done;
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
