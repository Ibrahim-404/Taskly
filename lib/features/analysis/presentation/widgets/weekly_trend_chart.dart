import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tasks_manager/features/analysis/domain/entities/weekly_performance.dart';

class WeeklyTrendChart extends StatelessWidget {
  final WeeklyPerformance performance;

  const WeeklyTrendChart({super.key, required this.performance});

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
            'Weekly Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, animValue, child) {
                return LineChart(
                  LineChartData(
                    minY: 0,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: cs.outlineVariant.withValues(alpha: 0.5),
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                value == 0 ? 'Last Week' : 'This Week',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            );
                          },
                          interval: 1,
                          reservedSize: 28,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: cs.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(
                            0,
                            performance.lastWeekCompleted * animValue,
                          ),
                          FlSpot(
                            1,
                            performance.thisWeekCompleted * animValue,
                          ),
                        ],
                        isCurved: true,
                        color: cs.primary,
                        barWidth: 3,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 5,
                              color: cs.primary,
                              strokeWidth: 2,
                              strokeColor: cs.surface,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: cs.primary.withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                color: cs.primary.withValues(alpha: 0.3),
                label: 'Last: ${performance.lastWeekCompleted}',
                cs: cs,
              ),
              const SizedBox(width: 24),
              _LegendItem(
                color: cs.primary,
                label: 'This: ${performance.thisWeekCompleted}',
                cs: cs,
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: performance.isImprovement
                      ? Colors.green.withValues(alpha: 0.1)
                      : cs.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      performance.isImprovement
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 16,
                      color: performance.isImprovement ? Colors.green : cs.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${performance.changePercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: performance.isImprovement
                            ? Colors.green
                            : cs.error,
                      ),
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

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final ColorScheme cs;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
