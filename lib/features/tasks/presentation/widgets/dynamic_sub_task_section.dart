import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_form_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_row_for_sub_task.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class DynamicSubTaskSection extends StatelessWidget {
  final TaskFormController taskFormController;
  const DynamicSubTaskSection({super.key, required this.taskFormController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.subTasks,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => taskFormController.addSubTask(),
              icon: const Icon(Icons.add_circle, color: AppColors.blue),
            ),
          ],
        ),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskFormController.subTasksList.length,
            itemBuilder: (context, index) {
              final subTask = taskFormController.subTasksList[index];
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
                        color: AppColors.error,
                      ),
                      onPressed: () => taskFormController.removeSubTask(index),
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
