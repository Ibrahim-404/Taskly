import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  void _confirmDeleteAll(BuildContext context) {
    Get.defaultDialog(
      title: 'Delete All Data',
      middleText: 'This will permanently delete all tasks and reset your profile. This cannot be undone.',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      buttonColor: context.theme.colorScheme.error,
      textCancel: 'Cancel',
      onConfirm: () {
        // TODO: implement data wipe
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 24),
          child: Text(
            'ACCOUNT',
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
              Obx(() => ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Email'),
                subtitle: Text(ctrl.profile.value?.email ?? ''),
              )),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              Obx(() => ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Member Since'),
                subtitle: Text(ctrl.accountAge),
              )),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              ListTile(
                leading: Icon(Icons.delete_forever, color: context.theme.colorScheme.error),
                title: Text('Delete All Data', style: TextStyle(color: context.theme.colorScheme.error)),
                onTap: () => _confirmDeleteAll(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
