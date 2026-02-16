import 'package:flutter/material.dart';

class TaskComposition extends StatefulWidget {
  const TaskComposition({super.key});

  @override
  State<TaskComposition> createState() => _TaskCompositionState();
}

class _TaskCompositionState extends State<TaskComposition> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Wrap(
          children: [
            InkWell(
              onTap: () {},
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Task 1"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add, size: 50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
