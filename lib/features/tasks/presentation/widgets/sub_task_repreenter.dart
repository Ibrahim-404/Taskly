import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class SubTaskRepresenter extends StatefulWidget {
  final SubTaskEntity subTaskEntity;
  final TaskController taskController;

  const SubTaskRepresenter({
    super.key,
    required this.subTaskEntity,
    required this.taskController,
  });

  @override
  State<SubTaskRepresenter> createState() => _SubTaskRepresenterState();
}

class _SubTaskRepresenterState extends State<SubTaskRepresenter> {
  bool selectedShowTask = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.subTaskEntity.isDone,
              onChanged: (bool? value) {
                widget.taskController.completeSubTaskFun(
                  subTaskId: widget.subTaskEntity.id.toString(),
                  taskState: widget.subTaskEntity.isDone,
                );
              },
            ),

            widget.subTaskEntity.isDone
                ? Text(
                    widget.subTaskEntity.title,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : Text(widget.subTaskEntity.title),

            const Spacer(),

            GestureDetector(
              onTap: () {
                if (widget.subTaskEntity.description.isEmpty) return;
                setState(() {
                  selectedShowTask = !selectedShowTask;
                });
              },

              child: AnimatedRotation(
                turns: selectedShowTask ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ],
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),

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

          child: selectedShowTask
              ? Padding(
                  key: const ValueKey('description'),
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text("Task Description Here"),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
