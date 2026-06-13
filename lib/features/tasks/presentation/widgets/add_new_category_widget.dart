import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/core/utils/app_validators.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class AddNewCategoryWidget extends StatelessWidget {
  const AddNewCategoryWidget({
    super.key,
    required this.controller,
    required this.formKey,
    required this.taskController,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add_rounded, color: cs.primary, size: 20),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) => AppValidators.requiredField(
                    context,
                    value,
                    AppLocalizations.of(context)!.pleaseEnterCategoryName,
                  ),
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.categoryName,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        taskController.addANewCategory(controller.text);
                        Navigator.pop(context);
                        controller.clear();
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.add),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
