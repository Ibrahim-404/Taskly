import 'package:flutter/material.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/task_composition.dart';

class TaskMainScreen extends StatelessWidget {
  const TaskMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: TaskComposition(),
    );
  }
}
