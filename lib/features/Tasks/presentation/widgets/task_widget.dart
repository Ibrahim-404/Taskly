import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class TaskWidget extends StatelessWidget {
  final TaskController taskController;
  const TaskWidget({super.key, required this.taskController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(""),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Task Name: "),
            SizedBox(width: 20),
            Checkbox(value: false, onChanged: (_) {}),
          ],
        ),
      ],
    );
  }
}
