import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/theme/app_theme.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';
import 'package:tasks_manager/features/profile/presentation/screens/profile_screen.dart';
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
                  GetBuilder<ProfileController>(
                    builder: (ctrl) => GestureDetector(
                      onTap: () => Get.to(() => const ProfileScreen()),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: ctrl.profile.value?.imagePath != null
                                ? FileImage(File(ctrl.profile.value!.imagePath!))
                                : const NetworkImage(AppStrings.profileImageUrl)
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  GetBuilder<ProfileController>(
                    builder: (ctrl) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeBack,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ctrl.profile.value?.name ?? 'User',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
