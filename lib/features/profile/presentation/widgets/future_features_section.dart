import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FutureFeaturesSection extends StatelessWidget {
  const FutureFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 24),
          child: Text(
            'MORE FROM TASKLY',
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
              _FeatureTile(
                icon: Icons.cloud_sync,
                title: 'Cloud Sync',
                subtitle: 'Backup and sync across devices',
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              _FeatureTile(
                icon: Icons.groups,
                title: 'Team Collaboration',
                subtitle: 'Share tasks and projects with your team',
              ),
              Divider(height: 1, indent: 56, color: context.theme.colorScheme.outlineVariant),
              _FeatureTile(
                icon: Icons.auto_awesome,
                title: 'AI Insights',
                subtitle: 'Smart suggestions and productivity insights',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.theme.colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: context.theme.colorScheme.onSurfaceVariant)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
