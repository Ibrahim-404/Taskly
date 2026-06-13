import 'package:tasks_manager/features/analysis/domain/entities/category_analytics.dart';
import 'package:tasks_manager/features/analysis/domain/entities/weekly_performance.dart';

class AnalyticsData {
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final int overdueTasks;
  final List<CategoryAnalytics> categoryAnalytics;
  final WeeklyPerformance weeklyPerformance;
  final String mostProductiveCategory;
  final String leastProductiveCategory;
  final String highestCompletionCategory;
  final String mostPendingCategory;
  final double thisWeekCompletionRate;

  const AnalyticsData({
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.overdueTasks,
    required this.categoryAnalytics,
    required this.weeklyPerformance,
    required this.mostProductiveCategory,
    required this.leastProductiveCategory,
    required this.highestCompletionCategory,
    required this.mostPendingCategory,
    required this.thisWeekCompletionRate,
  });

  double get completionPercentage =>
      totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;
}
