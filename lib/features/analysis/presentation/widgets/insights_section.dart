import 'package:flutter/material.dart';
import 'package:tasks_manager/features/analysis/domain/entities/analytics_data.dart';

class InsightsSection extends StatelessWidget {
  final AnalyticsData data;

  const InsightsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Insights', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _InsightRow(
              icon: Icons.star,
              iconColor: Colors.amber,
              label: 'Most Productive',
              value: data.mostProductiveCategory,
            ),
            _InsightRow(
              icon: Icons.info_outline,
              iconColor: Colors.grey,
              label: 'Least Productive',
              value: data.leastProductiveCategory,
            ),
            _InsightRow(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              label: 'Highest Completion',
              value: data.highestCompletionCategory,
            ),
            _InsightRow(
              icon: Icons.pending,
              iconColor: Colors.orange,
              label: 'Most Pending',
              value: data.mostPendingCategory,
            ),
            const Divider(height: 24),
            _InsightRow(
              icon: Icons.warning,
              iconColor: Colors.red,
              label: 'Overdue Tasks',
              value: data.overdueTasks.toString(),
            ),
            _InsightRow(
              icon: Icons.speed,
              iconColor: Colors.blue,
              label: 'This Week Rate',
              value: '${data.thisWeekCompletionRate.toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InsightRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
