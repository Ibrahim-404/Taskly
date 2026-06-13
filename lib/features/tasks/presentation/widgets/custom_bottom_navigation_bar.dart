import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';
import 'package:tasks_manager/core/const/app_strings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    final cs = Theme.of(context).colorScheme;

    return Obx(() {
      final selectedIndex = controller.selectedIndex;
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: cs.outlineVariant.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: AppStrings.home,
                  isSelected: selectedIndex == 0,
                  onTap: () => controller.updateSelectedIndex(0),
                ),
                _NavItem(
                  icon: Icons.add_circle_rounded,
                  label: AppStrings.add,
                  isSelected: selectedIndex == 1,
                  onTap: () => controller.updateSelectedIndex(1),
                ),
                _NavItem(
                  icon: Icons.search_rounded,
                  label: AppStrings.search,
                  isSelected: selectedIndex == 2,
                  onTap: () => controller.updateSelectedIndex(2),
                ),
                _NavItem(
                  icon: Icons.bar_chart_rounded,
                  label: AppStrings.analytics,
                  isSelected: selectedIndex == 3,
                  onTap: () => controller.updateSelectedIndex(3),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? cs.primary : cs.onSurfaceVariant,
              size: 26,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
