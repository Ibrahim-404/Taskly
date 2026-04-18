import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/strings.dart';
import 'package:tasks_manager/features/tasks/domain/entities/sub_task_entity.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class CustomButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TaskController taskController;
  final AddtaskCategoryController addtaskCategoryController;

  const CustomButton({
    super.key,
    required this.formKey,
    required this.taskController,
    required this.addtaskCategoryController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2575FC).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            if (formKey.currentState?.validate() ?? false) {
              if (addtaskCategoryController.selectedCategory.value == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a category')),
                );
                return;
              }

              final date =
                  addtaskCategoryController.selectedDeadline.value ??
                  DateTime.now();
              final time =
                  addtaskCategoryController.selectedTime.value ??
                  TimeOfDay.now();
              final taskDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );

              final subTasks = taskController.subTasksList
                  .where(
                    (sub) =>
                        sub.subTaskTextEditingController.text.trim().isNotEmpty,
                  )
                  .map(
                    (sub) => SubTaskEntity(
                      id: 0,
                      title: sub.subTaskTextEditingController.text.trim(),
                      description: sub
                          .subTaskDescriptionTextEditingController
                          .text
                          .trim(),
                      isDone: false,
                      taskId: 0,
                    ),
                  )
                  .toList();

              final newTask = TaskEntity(
                id: 0,
                title: addtaskCategoryController.taskName.text.trim(),
                description: addtaskCategoryController.taskDescription.text
                    .trim(),
                date: taskDateTime,
                categoryId: addtaskCategoryController.pickCategoryId.value,
                isDone: false,
                subTasks: subTasks,
              );

              await taskController.addANewTask(newTask);
              await taskController.fetchTasks();
              taskController.clearSubTasks();
              addtaskCategoryController.clearAll();

              if (taskController.taskErrorMessage.value.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(taskController.taskErrorMessage.value),
                  ),
                );
              } else {
                log(
                  name: 'Task',
                  "CategoryID:${newTask.categoryId}\n Task title${newTask.title} \n Task description:${newTask.description} \n Task date:${newTask.date} \n Task deadline:${newTask.isDone} \n Sub Tasks:${newTask.subTasks}",
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task added successfully')),
                );
                Navigator.of(context).pop();
              }
            }
          },
          child: const Center(
            child: Text(
              Strings.addTask,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
