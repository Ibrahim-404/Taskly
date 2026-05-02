import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/picker_button.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class ChoiceDeadline extends StatelessWidget {
  const ChoiceDeadline({super.key, required this.addtaskCategoryController});
  final AddtaskCategoryController addtaskCategoryController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PickerButton(
            icon: Icons.calendar_today_rounded,
            label: Obx(
              () => Text(
                addtaskCategoryController.isDatePicked.value
                    ? "${addtaskCategoryController.selectedDeadline.value!.day}/${addtaskCategoryController.selectedDeadline.value!.month}/${addtaskCategoryController.selectedDeadline.value!.year}"
                    : AppLocalizations.of(context)!.setDate,
              ),
            ),
            onTap: () async {
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
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PickerButton(
            icon: Icons.access_time_rounded,
            label: Obx(
              () => Text(
                addtaskCategoryController.isTimePicked.value
                    ? "${addtaskCategoryController.selectedTime.value!.hour}:${addtaskCategoryController.selectedTime.value!.minute.toString().padLeft(2, '0')}"
                    : AppLocalizations.of(context)!.setTime,
              ),
            ),
            onTap: () async {
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
          ),
        ),
      ],
    );
  }
}
