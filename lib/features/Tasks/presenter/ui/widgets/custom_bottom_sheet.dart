import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/choice_deadline.dart';
import 'package:tasks_manager/Core/strings.dart';

class CustomBottomSheet extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final GlobalKey<FormState> formKey;

  const CustomBottomSheet({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.formKey,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  // Local state to hold the selected date and time before submission
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Adjust padding based on keyboard visibility to prevent overlapping
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  Strings.addNewTask,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Title Field
                TextFormField(
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                    labelText: Strings.title,
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? Strings.titleRequired : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: widget.descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: Strings.description,
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? Strings.descriptionRequired : null,
                ),
                const SizedBox(height: 20),
                ChoiceDeadline(addtaskCategoryController: Get.find()),
                const SizedBox(height: 30),

                // Submit Action
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {}
                  },
                  child: const Text(Strings.createTask),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
