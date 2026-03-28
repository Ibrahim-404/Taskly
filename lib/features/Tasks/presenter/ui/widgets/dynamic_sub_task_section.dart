import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_row_for_sub_Task.dart';
import 'package:tasks_manager/Core/strings.dart';

class DynamicSubTaskSection extends StatelessWidget {
  final TaskController taskController;
  const DynamicSubTaskSection({super.key, required this.taskController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              Strings.subTasks,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => taskController.addSubTask(),
              icon: const Icon(Icons.add_circle, color: Colors.blue),
            ),
          ],
        ),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskController.subTasksList.length,
            itemBuilder: (context, index) {
              final subTask = taskController.subTasksList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomRowForSubTask(
                        controller: subTask.subTaskTextEditingController,
                        description:
                            subTask.subTaskDescriptionTextEditingController,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () => taskController.removeSubTask(index),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
