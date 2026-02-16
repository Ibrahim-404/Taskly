import 'package:flutter/material.dart';

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
                  "Add New Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Title Field
                TextFormField(
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: widget.descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Description is required' : null,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) setState(() => selectedDate = date);
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          selectedDate == null
                              ? "Set Date"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) setState(() => selectedTime = time);
                        },
                        icon: const Icon(Icons.access_time),
                        label: Text(
                          selectedTime == null
                              ? "Set Time"
                              : selectedTime!.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    if (widget.formKey.currentState!.validate()) {
                      _handleSubmit();
                    }
                  },
                  child: const Text("Create Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    // Collect all data and pass it to your logic layer
    final title = widget.titleController.text;
    final description = widget.descriptionController.text;

    if (selectedDate != null && selectedTime != null) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
    }
  }
}
