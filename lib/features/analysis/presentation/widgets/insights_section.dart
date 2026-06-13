import 'package:flutter/material.dart';
import 'package:tasks_manager/features/analysis/domain/entities/analytics_data.dart';

class InsightsSection extends StatelessWidget {
  final AnalyticsData data;

  const InsightsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insights',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          _InsightRow(
            icon: Icons.star_rounded,
            iconColor: cs.tertiary,
            label: 'Most Productive',
            value: data.mostProductiveCategory,
            cs: cs,
          ),
          _sectionDivider(cs),
          _InsightRow(
            icon: Icons.info_outline_rounded,
            iconColor: cs.onSurfaceVariant,
            label: 'Least Productive',
            value: data.leastProductiveCategory,
            cs: cs,
          ),
          _sectionDivider(cs),
          _InsightRow(
            icon: Icons.check_circle_rounded,
            iconColor: Colors.green,
            label: 'Highest Completion',
            value: data.highestCompletionCategory,
            cs: cs,
          ),
          _sectionDivider(cs),
          _InsightRow(
            icon: Icons.pending_rounded,
            iconColor: Colors.orange,
            label: 'Most Pending',
            value: data.mostPendingCategory,
            cs: cs,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(color: cs.outlineVariant, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _InsightRow(
              icon: Icons.warning_rounded,
              iconColor: cs.error,
              label: 'Overdue Tasks',
              value: data.overdueTasks.toString(),
              cs: cs,
            ),
          ),
          _sectionDivider(cs),
          _InsightRow(
            icon: Icons.speed_rounded,
            iconColor: cs.primary,
            label: 'This Week Rate',
            value: '${data.thisWeekCompletionRate.toStringAsFixed(1)}%',
            cs: cs,
          ),
        ],
      ),
    );
  }

  Widget _sectionDivider(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(color: cs.outlineVariant.withValues(alpha: 0.5), height: 1),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final ColorScheme cs;

  const _InsightRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: cs.onSurface,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
