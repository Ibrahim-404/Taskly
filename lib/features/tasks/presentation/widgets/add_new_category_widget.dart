import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';
import 'package:tasks_manager/core/utils/app_validators.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class AddNewCategoryWidget extends StatelessWidget {
  const AddNewCategoryWidget({
    super.key,
    required this.widget,
    required this.taskController,
  });

  final TaskComposition widget;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) => AppValidators.requiredField(
                          context,
                          value,
                          AppLocalizations.of(context)!.pleaseEnterCategoryName,
                        ),
                        controller: widget.controller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: AppLocalizations.of(context)!.categoryName,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueAccent,
                        ),
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            taskController.addANewCategory(
                              widget.controller.text,
                            );
                            Navigator.pop(context);
                            widget.controller.clear();
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.add),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: CircleAvatar(
          backgroundColor: AppColors.blue,
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
