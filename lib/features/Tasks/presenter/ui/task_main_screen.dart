import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_show_dialog_for_add_new_Task.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/task_composition.dart';

class TaskMainScreen extends StatefulWidget {
  const TaskMainScreen({super.key});

  @override
  State<TaskMainScreen> createState() => _TaskMainScreenState();
}

class _TaskMainScreenState extends State<TaskMainScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController mainDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    mainDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CustomShowDialogForAddNewTask(
              taskController: taskController,
              titleController: titleController,
              mainDescriptionController: mainDescriptionController,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: TaskComposition(),
    );
  }
}
