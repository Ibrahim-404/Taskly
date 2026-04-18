import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';
import 'package:tasks_manager/core/const/strings.dart';

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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.pleaseEnterCategoryName;
                          }
                          return null;
                        },
                        controller: widget.controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: Strings.categoryName,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
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
                        child: const Text(Strings.add),
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
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
