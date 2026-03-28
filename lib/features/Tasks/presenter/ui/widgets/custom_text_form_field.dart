import 'package:flutter/material.dart';
import 'package:tasks_manager/Core/const/strings.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: Strings.enterTaskName,

        filled: true,
        fillColor: Colors.grey.shade100,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
        ),
      ),
    );
  }
}
