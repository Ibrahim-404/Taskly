import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/enums/view_state.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/about_section.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/account_section.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/appearance_section.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/future_features_section.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/language_tile.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/notification_section.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:tasks_manager/features/profile/presentation/widgets/profile_stats_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ctrl.state == ViewState.busy && ctrl.profile.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: const [
            ProfileHeaderCard(),
            SizedBox(height: 12),
            ProfileStatsRow(),
            SizedBox(height: 24),
            AppearanceSection(),
            LanguageTile(),
            NotificationSection(),
            AccountSection(),
            FutureFeaturesSection(),
            AboutSection(),
            SizedBox(height: 32),
          ],
        );
      }),
    );
  }
}
