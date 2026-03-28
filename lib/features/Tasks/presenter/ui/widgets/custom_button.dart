import 'package:flutter/material.dart';
import 'package:tasks_manager/Core/const/strings.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Logic to add task
        Navigator.pop(context);
      },
      child: const Text(Strings.addTask),
    );
  }
}
