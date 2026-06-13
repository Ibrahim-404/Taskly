import 'package:flutter/material.dart';

class TaskTag extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final IconData? prefix;

  const TaskTag({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefix != null) ...[
            Icon(prefix, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
