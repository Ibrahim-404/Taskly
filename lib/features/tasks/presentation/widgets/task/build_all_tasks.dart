import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';
import 'package:tasks_manager/core/const/app_colors.dart';

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
            style: TextStyle(fontSize: 16, color: AppColors.grey),
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
