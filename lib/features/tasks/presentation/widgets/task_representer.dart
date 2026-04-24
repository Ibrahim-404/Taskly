import 'package:flutter/material.dart';

class TaskRepresenter extends StatelessWidget {
  final int progressValue;
  const TaskRepresenter({super.key, required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                Column(children: [Text("Task Name"), Text("Task Description")]),
                GestureDetector(
                  onTap: () {
                    // Add your delete button action here
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("progress"), Text("${progressValue}%")],
                ),
                LinearProgressIndicator(value: progressValue / 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  final String status;
  const StatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text("Status"));
  }
}
