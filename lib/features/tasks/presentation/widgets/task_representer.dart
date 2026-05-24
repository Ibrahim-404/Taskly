import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/sub_task_repreenter.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tags.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_progress_indicator.dart';

class TaskRepresenter extends StatefulWidget {
  final TaskEntity task;

  const TaskRepresenter({super.key, required this.task});

  @override
  State<TaskRepresenter> createState() => _TaskRepresenterState();
}

class _TaskRepresenterState extends State<TaskRepresenter> {
  bool selectedShowTask = false;

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    int completedSubTasks = widget.task.subTasks
        .where((st) => st.isDone)
        .length;
    int totalSubTasks = widget.task.subTasks.length;
    double progress = totalSubTasks == 0
        ? (widget.task.isDone ? 1.0 : 0.0)
        : (completedSubTasks / totalSubTasks);
    int progressPercentage = (progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(
            color: widget.task.isDone ? AppColors.success : AppColors.error,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.task.isMissed
                  ? const Icon(
                      Icons.warning_amber_outlined,
                      color: AppColors.error,
                    )
                  : Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: widget.task.isDone,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          controller.completeTaskFun(
                            taskId: widget.task.id.toString(),
                          );
                        },
                      ),
                    ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.task.description,
                      style: TextStyle(fontSize: 14, color: AppColors.grey600),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedShowTask = !selectedShowTask;
                  });
                },
                icon: AnimatedRotation(
                  turns: selectedShowTask ? 0.25 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          TaskTags(
            isDone: widget.task.isDone,
            date: widget.task.date,
            categoryName: widget.task.categoryName ?? 'Life',
            priority: widget.task.priorityStatus.name,
          ),
          const SizedBox(height: 24),
          TaskProgressIndicator(
            progressPercentage: progressPercentage,
            progress: progress,
          ),

          if (selectedShowTask && widget.task.subTasks.isNotEmpty) ...[
            const SizedBox(height: 24),

            Text(
              'SUBTASKS ($completedSubTasks/$totalSubTasks)',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...widget.task.subTasks.map((subTask) {
              return SubTaskRepresenter(
                subTaskEntity: subTask,
                taskController: controller,
              );
            }),
          ],
        ],
      ),
    );
  }
}
