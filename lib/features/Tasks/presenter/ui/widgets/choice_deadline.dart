import 'package:flutter/material.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/category_management.dart';
import 'package:tasks_manager/Core/strings.dart';

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
              // if (date != null) setState(() => selectedDate = date);
            },
            icon: const Icon(Icons.calendar_month),
            label: Text(Strings.setDate),
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
              // if (time != null) setState(() => selectedTime = time);
            },
            icon: const Icon(Icons.access_time),
            label: Text(
              //   selectedTime == null
              //       ? "Set Time"
              //       : selectedTime!.format(context),
              // ),
              Strings.setTime,
            ),
          ),
        ),
      ],
    );
  }
}
