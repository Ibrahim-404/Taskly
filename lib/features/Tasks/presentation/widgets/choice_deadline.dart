import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/category_management.dart';
import 'package:tasks_manager/core/const/strings.dart';

class ChoiceDeadline extends StatelessWidget {
  const ChoiceDeadline({super.key, required this.addtaskCategoryController});
  final AddtaskCategoryController addtaskCategoryController;
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildPickerButton(
            context: context,
            icon: Icons.calendar_today_rounded,
            label: Obx(
              () => Text(
                addtaskCategoryController.isDatePicked.value
                    ? "${addtaskCategoryController.selectedDeadline.value!.day}/${addtaskCategoryController.selectedDeadline.value!.month}/${addtaskCategoryController.selectedDeadline.value!.year}"
                    : Strings.setDate,
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
          child: _buildPickerButton(
            context: context,
            icon: Icons.access_time_rounded,
            label: Obx(
              () => Text(
                addtaskCategoryController.isTimePicked.value
                    ? "${addtaskCategoryController.selectedTime.value!.hour}:${addtaskCategoryController.selectedTime.value!.minute.toString().padLeft(2, '0')}"
                    : Strings.setTime,
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

  Widget _buildPickerButton({
    required BuildContext context,
    required IconData icon,
    required Widget label,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: const Color(0xFF6A11CB)),
                const SizedBox(width: 8),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  child: label,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
