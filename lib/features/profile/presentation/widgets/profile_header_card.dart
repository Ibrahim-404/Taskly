import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/const/app_strings.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/avatar_picker_sheet.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Obx(() {
      final p = ctrl.profile.value;
      if (p == null) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showAvatarOptions(context),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: context.theme.colorScheme.primaryContainer,
                    backgroundImage: p.imagePath != null
                        ? FileImage(File(p.imagePath!))
                        : const NetworkImage(AppStrings.profileImageUrl)
                            as ImageProvider,
                    child: p.imagePath == null
                        ? Icon(Icons.person,
                            size: 44,
                            color: context.theme.colorScheme.onPrimaryContainer)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt,
                          size: 16, color: context.theme.colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ctrl.isEditingName.value ? _buildNameField(context, ctrl) : _buildNameDisplay(context, ctrl),
            const SizedBox(height: 4),
            Text(
              p.email,
              style: TextStyle(
                color: context.theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Member for ${ctrl.accountAge}',
              style: TextStyle(
                color: context.theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showAvatarOptions(BuildContext context) {
    Get.bottomSheet(const AvatarPickerSheet());
  }

  Widget _buildNameDisplay(BuildContext context, ProfileController ctrl) {
    return GestureDetector(
      onTap: () => ctrl.isEditingName.value = true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ctrl.profile.value!.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 6),
          Icon(Icons.edit, size: 18, color: context.theme.colorScheme.primary),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context, ProfileController ctrl) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 180,
          child: TextField(
            controller: ctrl.nameController,
            autofocus: true,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onSubmitted: (v) => ctrl.updateName(v),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.check, color: context.theme.colorScheme.primary),
          onPressed: () => ctrl.updateName(ctrl.nameController.text),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            ctrl.nameController.text = ctrl.profile.value?.name ?? '';
            ctrl.isEditingName.value = false;
          },
        ),
      ],
    );
  }
}
