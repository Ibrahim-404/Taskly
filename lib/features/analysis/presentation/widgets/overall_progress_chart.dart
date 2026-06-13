import 'package:flutter/material.dart';
import 'package:tasks_manager/features/analysis/domain/entities/analytics_data.dart';

class OverallProgressChart extends StatelessWidget {
  final AnalyticsData data;

  const OverallProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pct = data.completionPercentage;

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
            'Overall Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: pct / 100),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return CircularProgressIndicator(
                          value: value,
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                        );
                      },
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: pct),
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Text(
                                '${value.toInt()}%',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface,
                                ),
                              );
                            },
                          ),
                          Text(
                            'done',
                            style: TextStyle(
                              fontSize: 12,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: Column(
                  children: [
                    _StatItem(
                      label: 'Total',
                      value: data.totalTasks.toString(),
                      color: cs.primary,
                      cs: cs,
                    ),
                    const SizedBox(height: 12),
                    _StatItem(
                      label: 'Completed',
                      value: data.completedTasks.toString(),
                      color: Colors.green,
                      cs: cs,
                    ),
                    const SizedBox(height: 12),
                    _StatItem(
                      label: 'Pending',
                      value: data.pendingTasks.toString(),
                      color: Colors.orange,
                      cs: cs,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ColorScheme cs;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}
