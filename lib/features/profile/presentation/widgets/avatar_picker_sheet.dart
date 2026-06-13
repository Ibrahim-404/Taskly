import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';

class AvatarPickerSheet extends StatelessWidget {
  const AvatarPickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Get.back();
              ctrl.pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Get.back();
              ctrl.pickImage(ImageSource.gallery);
            },
          ),
          if (ctrl.profile.value?.imagePath != null)
            ListTile(
              leading: Icon(Icons.delete_outline, color: context.theme.colorScheme.error),
              title: Text('Remove photo', style: TextStyle(color: context.theme.colorScheme.error)),
              onTap: () {
                Get.back();
                ctrl.removeImage();
              },
            ),
        ],
      ),
    );
  }
}
