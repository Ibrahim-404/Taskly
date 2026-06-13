import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/theme_controller.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'APPEARANCE',
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
              ThemeModeTile(
                icon: Icons.light_mode,
                label: 'Light',
                mode: ThemeMode.light,
                current: themeCtrl,
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              ThemeModeTile(
                icon: Icons.dark_mode,
                label: 'Dark',
                mode: ThemeMode.dark,
                current: themeCtrl,
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              ThemeModeTile(
                icon: Icons.settings_brightness,
                label: 'System',
                mode: ThemeMode.system,
                current: themeCtrl,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ThemeModeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeMode mode;
  final ThemeController current;

  const ThemeModeTile({
    super.key,
    required this.icon,
    required this.label,
    required this.mode,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = current.isDarkMode
        ? mode == ThemeMode.dark
        : mode == ThemeMode.light;
    return Obx(() => ListTile(
      leading: Icon(icon, color: isSelected ? context.theme.colorScheme.primary : null),
      title: Text(label),
      trailing: isSelected
          ? Icon(Icons.check, color: context.theme.colorScheme.primary)
          : null,
      onTap: () {
        if (mode == ThemeMode.dark) {
          Get.changeThemeMode(ThemeMode.dark);
        } else if (mode == ThemeMode.light) {
          Get.changeThemeMode(ThemeMode.light);
        } else {
          Get.changeThemeMode(ThemeMode.system);
        }
      },
    ));
  }
}
