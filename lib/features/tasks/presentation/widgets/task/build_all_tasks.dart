import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';

class BuildAllTasks extends StatelessWidget {
  const BuildAllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Obx(() {
      if (controller.taskErrorMessage.value.isNotEmpty) {
        return Center(child: Text(controller.taskErrorMessage.value));
      }

      if (!controller.isTasksLoading.value && controller.tasks.isEmpty) {
        return const Center(
          child: Text(
            'No tasks available',
            style: TextStyle(fontSize: 16, color: AppColors.grey),
          ),
        );
      }

      return Skeletonizer(
        enabled: controller.isTasksLoading.value,
        child: ListView.builder(
          itemCount: controller.isTasksLoading.value
              ? controller.tasks.length
              : controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.isTasksLoading.value
                ? TaskEntity.skeleton()
                : controller.tasks[index];
            return TaskRepresenter(task: task);
          },
        ),
      );
    });
  }
}
