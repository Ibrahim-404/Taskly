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
    final AnalyticsController controller = Get.find();

    return Obx(() {
      final data = controller.analyticsData.value;
      if (data == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: () async => controller.computeAnalytics(),
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          children: [
            OverallProgressChart(data: data),
            if (data.categoryAnalytics.isNotEmpty)
              CategoryBarChart(categories: data.categoryAnalytics),
            WeeklyTrendChart(performance: data.weeklyPerformance),
            InsightsSection(data: data),
          ],
        ),
      );
    });
  }
}
