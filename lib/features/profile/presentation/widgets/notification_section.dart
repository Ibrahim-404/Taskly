import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 24),
          child: Text(
            'NOTIFICATIONS',
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
          child: Obx(() => SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push Notifications'),
            subtitle: Text(ctrl.notificationsEnabled.value ? 'Task reminders enabled' : 'All reminders disabled'),
            value: ctrl.notificationsEnabled.value,
            onChanged: (v) => ctrl.toggleNotifications(v),
          )),
        ),
      ],
    );
  }
}
