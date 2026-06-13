import 'package:flutter/material.dart';

class TaskSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const TaskSectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: cs.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
