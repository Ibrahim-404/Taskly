import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class SubTaskRepresenter extends StatefulWidget {
  final SubTaskEntity subTaskEntity;
  final TaskController taskController;
  final bool onlyRepresenter;
  const SubTaskRepresenter({
    super.key,
    required this.subTaskEntity,
    required this.taskController,
    required this.onlyRepresenter,
  });

  @override
  State<SubTaskRepresenter> createState() => _SubTaskRepresenterState();
}

class _SubTaskRepresenterState extends State<SubTaskRepresenter> {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: Checkbox(
                  value: widget.subTaskEntity.isDone,
                  onChanged: widget.onlyRepresenter
                      ? null
                      : (value) => widget.taskController.completeSubTaskFun(
                            subTaskId: widget.subTaskEntity.id.toString(),
                            taskState: value ?? false,
                          ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.subTaskEntity.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: widget.subTaskEntity.isDone
                        ? TextDecoration.lineThrough
                        : null,
                    color: widget.subTaskEntity.isDone
                        ? cs.onSurfaceVariant
                        : cs.onSurface,
                  ),
                ),
              ),
              if (widget.subTaskEntity.description.isNotEmpty)
                GestureDetector(
                  onTap: () => setState(
                      () => _showDescription = !_showDescription),
                  child: AnimatedRotation(
                    turns: _showDescription ? 0.25 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _showDescription
              ? Padding(
                  key: const ValueKey('description'),
                  padding: const EdgeInsets.only(left: 32, top: 4, bottom: 4),
                  child: Text(
                    widget.subTaskEntity.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
