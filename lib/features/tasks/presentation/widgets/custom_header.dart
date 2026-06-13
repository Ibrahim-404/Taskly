import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/theme/app_theme.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';
import 'package:tasks_manager/features/profile/presentation/screens/profile_screen.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/profile_avatar.dart';
import 'custom_wave_paint.dart';
import 'package:tasks_manager/core/const/app_strings.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 170),
                  painter: CustomWavePaint(
                    _controller.value,
                    gradientColors: AppTheme.headerGradient(context),
                  ),
                );
              },
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Obx(() {
                    final ctrl = Get.find<ProfileController>();
                    final p = ctrl.profile.value;
                    return ProfileAvatar(
                      imagePath: p?.imagePath,
                      name: p?.name ?? 'User',
                      radius: 24,
                      onTap: () => Get.to(() => const ProfileScreen()),
                    );
                  }),
                  const SizedBox(width: 14),
                  Obx(() {
                    final ctrl = Get.find<ProfileController>();
                    final name = ctrl.profile.value?.name ?? 'User';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeBack,
                          style: TextStyle(
                            color: cs.onPrimary.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          name,
                          style: TextStyle(
                            color: cs.onPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
