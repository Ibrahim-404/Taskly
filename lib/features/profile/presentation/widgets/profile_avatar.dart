import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imagePath;
  final String name;
  final double radius;
  final VoidCallback? onTap;
  final Widget? overlay;

  const ProfileAvatar({
    super.key,
    this.imagePath,
    required this.name,
    this.radius = 24,
    this.onTap,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';
    final hasImage = imagePath != null;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: cs.primaryContainer,
            backgroundImage: hasImage ? FileImage(File(imagePath!)) : null,
            child: hasImage
                ? null
                : Text(
                    initials,
                    style: TextStyle(
                      fontSize: radius * 0.7,
                      fontWeight: FontWeight.w600,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
          ),
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
