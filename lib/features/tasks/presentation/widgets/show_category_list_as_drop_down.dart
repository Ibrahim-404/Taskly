import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_form_controller.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class ShowCategoryListAsDropDown extends StatelessWidget {
  final TaskFormController taskFormController;
  const ShowCategoryListAsDropDown({
    super.key,
    required this.taskFormController,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => DropdownButtonFormField<String>(
          initialValue: taskFormController.selectedCategory.value == 0
              ? null
              : taskFormController.selectedCategory.value.toString(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: cs.primary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
          isExpanded: true,
          hint: Text(
            AppLocalizations.of(context)!.select,
            style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: cs.primary,
          ),
          items: taskFormController.categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat['id'].toString(),
              child: Text(
                cat['category_name'].toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final categoryId = int.parse(value);
              taskFormController.setSelectedCategory(categoryId);
            }
          },
        ),
      ),
    );
  }
}
