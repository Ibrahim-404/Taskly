import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_tags.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/task_progress_indicator.dart';

class TaskRepresenter extends StatelessWidget {
  final TaskEntity task;

  const TaskRepresenter({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    int completedSubTasks = task.subTasks.where((st) => st.isDone).length;
    int totalSubTasks = task.subTasks.length;
    double progress = totalSubTasks == 0
        ? (task.isDone ? 1.0 : 0.0)
        : (completedSubTasks / totalSubTasks);
    int progressPercentage = (progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(
            color: task.isDone ? AppColors.success : AppColors.error,
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
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: task.isDone,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (value) {
                    controller.completeTaskFun(task.id.toString());
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: TextStyle(fontSize: 14, color: AppColors.grey600),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  //TODO: show subtasks in a bottom sheet
                  // controller.showSubTasks(task.id.toString());
                },
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),

          const SizedBox(height: 16),
          TaskTags(date: task.date),
          const SizedBox(height: 24),
          TaskProgressIndicator(
            progressPercentage: progressPercentage,
            progress: progress,
          ),

          if (task.subTasks.isNotEmpty) ...[
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
            ...task.subTasks.map((subTask) {
              return Row(
                children: [
                  Checkbox(
                    value: subTask.isDone,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (value) {
                      controller.completeSubTaskFun(subTask.id.toString());
                    },
                  ),
                  Expanded(
                    child: Text(
                      subTask.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: subTask.isDone
                            ? AppColors.grey
                            : AppColors.black87,
                        decoration: subTask.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ],
      ),
    );
  }
}
