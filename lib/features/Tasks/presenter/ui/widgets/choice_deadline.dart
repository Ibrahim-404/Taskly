import 'package:flutter/material.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/category_management.dart';
import 'package:tasks_manager/Core/const/strings.dart';

class ChoiceDeadline extends StatelessWidget {
  const ChoiceDeadline({super.key, required this.addtaskCategoryController});
  final AddtaskCategoryController addtaskCategoryController;
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: addtaskCategoryController.selectedtime.value,
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );
            },
            icon: const Icon(Icons.calendar_month),
            label: Text(
              addtaskCategoryController.selectedtime.value != DateTime.now()
                  ? "${addtaskCategoryController.selectedtime.value.day}/${addtaskCategoryController.selectedtime.value.month}/${addtaskCategoryController.selectedtime.value.year}"
                  : Strings.setDate,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: addtaskCategoryController.selectedDate.value,
              );
            },
            icon: const Icon(Icons.access_time),
            label: Text(
              addtaskCategoryController.selectedDate.value != TimeOfDay.now()
                  ? Strings.setTime
                  : "${addtaskCategoryController.selectedDate.value.hour}:${addtaskCategoryController.selectedDate.value.minute}",
            ),
          ),
        ),
      ],
    );
  }
}
