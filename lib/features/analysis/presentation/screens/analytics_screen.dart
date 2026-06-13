import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/analysis/presentation/controllers/analytics_controller.dart';
import 'package:tasks_manager/features/analysis/presentation/widgets/category_bar_chart.dart';
import 'package:tasks_manager/features/analysis/presentation/widgets/insights_section.dart';
import 'package:tasks_manager/features/analysis/presentation/widgets/overall_progress_chart.dart';
import 'package:tasks_manager/features/analysis/presentation/widgets/weekly_trend_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalyticsController>();

    return Obx(() {
      final data = controller.analyticsData.value;
      if (data == null) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => controller.computeAnalytics(),
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            OverallProgressChart(data: data),
            if (data.categoryAnalytics.isNotEmpty) ...[
              const SizedBox(height: 8),
              CategoryBarChart(categories: data.categoryAnalytics),
            ],
            const SizedBox(height: 8),
            WeeklyTrendChart(performance: data.weeklyPerformance),
            const SizedBox(height: 8),
            InsightsSection(data: data),
          ],
        ),
      );
    });
  }
}
