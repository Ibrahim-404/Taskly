import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/const/app_strings.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 24),
          child: Text(
            'ABOUT',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Built With'),
                subtitle: const Text('Flutter & GetX'),
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              const ListTile(
                leading: Icon(Icons.favorite_outline),
                title: Text('AppName'),
                subtitle: Text('${AppStrings.appName} — Your personal task manager'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
