import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final MainScreenController mainScreenController;

  const BottomNavigationBarItemWidget({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.mainScreenController,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = mainScreenController.selectedIndex == index;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              mainScreenController.updateSelectedIndex(index);
            },
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                final scale = 1 + (0.2 * value);
                final translateY = -10 * value;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, translateY),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.white.withOpacity(0.6),
                                      blurRadius: 12 * value,
                                      offset: const Offset(0, 4),
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            icon,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.white70,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
