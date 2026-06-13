import 'package:flutter/material.dart';
import 'package:tasks_manager/features/analysis/domain/entities/analytics_data.dart';

class OverallProgressChart extends StatelessWidget {
  final AnalyticsData data;

  const OverallProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Overall Progress',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: data.completionPercentage / 100,
                        strokeWidth: 10,
                        backgroundColor: cs.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                      ),
                      Center(
                        child: Text(
                          '${data.completionPercentage.toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _StatRow(
                          label: 'Total',
                          value: data.totalTasks.toString(),
                          color: cs.primary),
                      const SizedBox(height: 8),
                      _StatRow(
                          label: 'Completed',
                          value: data.completedTasks.toString(),
                          color: Colors.green),
                      const SizedBox(height: 8),
                      _StatRow(
                          label: 'Pending',
                          value: data.pendingTasks.toString(),
                          color: Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
