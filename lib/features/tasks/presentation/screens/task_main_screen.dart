import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_show_dialog_for_add_new_Task.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';

class TaskMainScreen extends StatefulWidget {
  const TaskMainScreen({super.key});

  @override
  State<TaskMainScreen> createState() => _TaskMainScreenState();
}

class _TaskMainScreenState extends State<TaskMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final TaskController taskController = Get.find();
          taskController.fetchCategories();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomShowDialogForAddNewTask(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: TaskComposition(),
    );
  }
}
