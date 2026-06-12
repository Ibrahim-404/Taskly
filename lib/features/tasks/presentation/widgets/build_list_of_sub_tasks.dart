import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/sub_task_repreenter.dart';

class BuildListOfSubTasks extends StatelessWidget {
  final List<SubTaskEntity> subTasks;
  final TaskController taskController;
  const BuildListOfSubTasks({
    super.key,
    required this.subTasks,
    required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subTasks.length,
      itemBuilder: (context, index) {
        taskController.isTasksLoading.value
            ? SubTaskEntity.skeleton()
            : subTasks[index];
        return SubTaskRepresenter(
          subTaskEntity: subTasks[index],
          taskController: taskController,
          onlyRepresenter: false,
        );
      },
    );
  }
}
