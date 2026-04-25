import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(
            color: task.isDone ? Colors.green : Colors.red,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('HIGH', Colors.red, Colors.white),
              _buildTag(
                'IN PROGRESS',
                Colors.blue.shade100,
                Colors.blue.shade700,
              ),
              _buildTag(
                "${task.date.year}-${task.date.month.toString().padLeft(2, '0')}-${task.date.day.toString().padLeft(2, '0')}", // تمثيل بسيط للتاريخ
                Colors.grey.shade200,
                Colors.black87,
                icon: Icons.calendar_today,
              ),
              _buildTag('#Work', Colors.blue.shade50, Colors.blue.shade700),
              _buildTag(
                '#Important',
                Colors.orange.shade50,
                Colors.orange.shade700,
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PROGRESS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '$progressPercentage%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            color: Colors.blue.shade700,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),

          if (task.subTasks.isNotEmpty) ...[
            const SizedBox(height: 24),

            Text(
              'SUBTASKS ($completedSubTasks/$totalSubTasks)',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
                        color: subTask.isDone ? Colors.grey : Colors.black87,
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

  Widget _buildTag(
    String text,
    Color bgColor,
    Color textColor, {
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildAllTasks extends StatelessWidget {
  const BuildAllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Obx(() {
      if (controller.isTasksLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.taskErrorMessage.value.isNotEmpty) {
        return Center(child: Text(controller.taskErrorMessage.value));
      }

      if (controller.tasks.isEmpty) {
        return const Center(
          child: Text(
            'No tasks available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return TaskRepresenter(task: task);
        },
      );
    });
  }
}
