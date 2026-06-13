import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/profile/presentation/controllers/profile_controller.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();
    return Obx(() => Row(
      children: [
        Expanded(child: _buildStatCard(context, 'Active', '${ctrl.totalActiveTasks}', Icons.check_circle_outline)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(context, 'Completed', '${ctrl.totalCompletedTasks}', Icons.task_alt)),
      ],
    ));
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: context.theme.colorScheme.primary, size: 24),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 13, color: context.theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
