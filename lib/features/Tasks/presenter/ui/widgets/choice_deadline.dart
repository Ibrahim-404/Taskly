import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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
                initialDate:
                    addtaskCategoryController.selectedDeadline.value ??
                    DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );
              if (date != null) {
                addtaskCategoryController.setSelectedDeadline(date);
              }
            },
            icon: const Icon(Icons.calendar_month),
            label: Obx(
              () => Text(
                addtaskCategoryController.isDatePicked.value
                    ? "${addtaskCategoryController.selectedDeadline.value!.day}/${addtaskCategoryController.selectedDeadline.value!.month}/${addtaskCategoryController.selectedDeadline.value!.year}"
                    : Strings.setDate,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    addtaskCategoryController.selectedTime.value ??
                    TimeOfDay.now(),
              );
              if (time != null) {
                addtaskCategoryController.setSelectedTime(time);
              }
            },
            icon: const Icon(Icons.access_time),
            label: Obx(
              () => Text(
                addtaskCategoryController.isTimePicked.value
                    ? "${addtaskCategoryController.selectedTime.value!.hour}:${addtaskCategoryController.selectedTime.value!.minute.toString().padLeft(2, '0')}"
                    : Strings.setTime,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
