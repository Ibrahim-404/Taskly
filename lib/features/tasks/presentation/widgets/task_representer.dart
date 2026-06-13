import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/sub_task_repreenter.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tags.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_progress_indicator.dart';

class TaskRepresenter extends StatefulWidget {
  final TaskEntity task;
  final bool onlyRepresenter;

  const TaskRepresenter({
    super.key,
    required this.task,
    required this.onlyRepresenter,
  });

  @override
  State<TaskRepresenter> createState() => _TaskRepresenterState();
}

class _TaskRepresenterState extends State<TaskRepresenter> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final cs = Theme.of(context).colorScheme;

    int completedSubTasks = widget.task.subTasks.where((st) => st.isDone).length;
    int totalSubTasks = widget.task.subTasks.length;
    double progress = totalSubTasks == 0
        ? (widget.task.isDone ? 1.0 : 0.0)
        : (completedSubTasks / totalSubTasks);
    int progressPercentage = (progress * 100).toInt();

    final priorityColor = widget.task.isDone
        ? cs.primary
        : widget.task.isMissed
            ? cs.error
            : getPriorityColor(widget.task.priorityStatus.name, cs);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            if (widget.task.subTasks.isNotEmpty) {
              setState(() => _expanded = !_expanded);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: widget.task.isDone,
                        onChanged: widget.onlyRepresenter
                            ? null
                            : (value) => controller.completeTaskFun(
                                  taskId: widget.task.id.toString(),
                                ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.task.title,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    decoration: widget.task.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: widget.task.isDone
                                        ? cs.onSurfaceVariant
                                        : cs.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _PriorityBadge(
                                color: priorityColor,
                                label: widget.task.priorityStatus.name,
                              ),
                            ],
                          ),
                          if (widget.task.description.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              widget.task.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TaskTags(
                  isDone: widget.task.isDone,
                  date: widget.task.date,
                  categoryName: widget.task.categoryName ?? 'Life',
                  priority: widget.task.priorityStatus.name,
                ),
                if (totalSubTasks > 0) ...[
                  const SizedBox(height: 16),
                  TaskProgressIndicator(
                    progressPercentage: progressPercentage,
                    progress: progress,
                  ),
                  if (_expanded) ...[
                    const SizedBox(height: 16),
                    Divider(color: cs.outlineVariant, height: 1),
                    const SizedBox(height: 12),
                    ...widget.task.subTasks.map((subTask) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SubTaskRepresenter(
                          onlyRepresenter: widget.onlyRepresenter,
                          subTaskEntity: subTask,
                          taskController: controller,
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 4),
                  Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$completedSubTasks/$totalSubTasks',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: cs.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'subtasks',
                              style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 4),
                            AnimatedRotation(
                              turns: _expanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 16,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getPriorityColor(String priority, ColorScheme cs) {
    switch (priority) {
      case 'high':
        return cs.error;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}

class _PriorityBadge extends StatelessWidget {
  final Color color;
  final String label;

  const _PriorityBadge({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
