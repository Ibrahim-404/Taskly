import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/features/analysis/domain/entities/analytics_data.dart';
import 'package:tasks_manager/features/analysis/domain/entities/category_analytics.dart';
import 'package:tasks_manager/features/analysis/domain/entities/weekly_performance.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class AnalyticsController extends BaseController {
  final TaskController _taskController = Get.find();
  final analyticsData = Rxn<AnalyticsData>();

  @override
  void onInit() {
    super.onInit();
    ever(_taskController.tasks, (_) => computeAnalytics());
    computeAnalytics();
  }

  void computeAnalytics() {
    final tasks = _taskController.tasks;
    if (tasks.isEmpty) {
      analyticsData.value = AnalyticsData(
        totalTasks: 0,
        completedTasks: 0,
        pendingTasks: 0,
        overdueTasks: 0,
        categoryAnalytics: [],
        weeklyPerformance: const WeeklyPerformance(
          lastWeekCompleted: 0,
          thisWeekCompleted: 0,
        ),
        mostProductiveCategory: '-',
        leastProductiveCategory: '-',
        highestCompletionCategory: '-',
        mostPendingCategory: '-',
        thisWeekCompletionRate: 0,
      );
      return;
    }

    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t.isDone).length;
    final pendingTasks = totalTasks - completedTasks;
    final overdueTasks = tasks.where((t) => t.isMissed).length;

    final categoryAnalytics = _computeCategoryAnalytics(tasks);
    final weeklyPerformance = _computeWeeklyPerformance(tasks);

    final mostProductiveCategory = _findMostProductive(categoryAnalytics);
    final leastProductiveCategory = _findLeastProductive(categoryAnalytics);
    final highestCompletionCategory = _findHighestCompletion(categoryAnalytics);
    final mostPendingCategory = _findMostPending(categoryAnalytics);
    final thisWeekCompletionRate = _computeThisWeekRate(tasks, completedTasks);

    analyticsData.value = AnalyticsData(
      totalTasks: totalTasks,
      completedTasks: completedTasks,
      pendingTasks: pendingTasks,
      overdueTasks: overdueTasks,
      categoryAnalytics: categoryAnalytics,
      weeklyPerformance: weeklyPerformance,
      mostProductiveCategory: mostProductiveCategory,
      leastProductiveCategory: leastProductiveCategory,
      highestCompletionCategory: highestCompletionCategory,
      mostPendingCategory: mostPendingCategory,
      thisWeekCompletionRate: thisWeekCompletionRate,
    );
  }

  List<CategoryAnalytics> _computeCategoryAnalytics(List<TaskEntity> tasks) {
    final Map<String, List<TaskEntity>> grouped = {};
    for (final task in tasks) {
      final name = task.categoryName ?? 'Uncategorized';
      grouped.putIfAbsent(name, () => []).add(task);
    }

    return grouped.entries.map((e) {
      final completed = e.value.where((t) => t.isDone).length;
      return CategoryAnalytics(
        categoryName: e.key,
        totalTasks: e.value.length,
        completedTasks: completed,
      );
    }).toList()
      ..sort((a, b) => b.totalTasks.compareTo(a.totalTasks));
  }

  WeeklyPerformance _computeWeeklyPerformance(List<TaskEntity> tasks) {
    final now = DateTime.now();
    final thisWeekStart = _weekStart(now);
    final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));

    final thisWeekCompleted = tasks.where((t) =>
        t.isDone &&
        !t.date.isBefore(thisWeekStart) &&
        t.date.isBefore(thisWeekStart.add(const Duration(days: 7)))).length;

    final lastWeekCompleted = tasks.where((t) =>
        t.isDone &&
        !t.date.isBefore(lastWeekStart) &&
        t.date.isBefore(thisWeekStart)).length;

    return WeeklyPerformance(
      lastWeekCompleted: lastWeekCompleted,
      thisWeekCompleted: thisWeekCompleted,
    );
  }

  DateTime _weekStart(DateTime date) {
    final daysFromMonday = (date.weekday - DateTime.monday) % 7;
    return DateTime(date.year, date.month, date.day - daysFromMonday);
  }

  String _findMostProductive(List<CategoryAnalytics> categories) {
    if (categories.isEmpty) return '-';
    return categories.reduce((a, b) =>
        a.completedTasks >= b.completedTasks ? a : b).categoryName;
  }

  String _findLeastProductive(List<CategoryAnalytics> categories) {
    if (categories.isEmpty) return '-';
    return categories
        .reduce((a, b) => a.completedTasks <= b.completedTasks ? a : b)
        .categoryName;
  }

  String _findHighestCompletion(List<CategoryAnalytics> categories) {
    if (categories.isEmpty) return '-';
    return categories
        .reduce((a, b) =>
            a.completionPercentage >= b.completionPercentage ? a : b)
        .categoryName;
  }

  String _findMostPending(List<CategoryAnalytics> categories) {
    if (categories.isEmpty) return '-';
    return categories
        .reduce((a, b) => a.pendingTasks >= b.pendingTasks ? a : b)
        .categoryName;
  }

  double _computeThisWeekRate(List<TaskEntity> tasks, int totalCompleted) {
    final now = DateTime.now();
    final thisWeekStart = _weekStart(now);
    final thisWeekCompleted = tasks.where((t) =>
        t.isDone &&
        !t.date.isBefore(thisWeekStart) &&
        t.date.isBefore(thisWeekStart.add(const Duration(days: 7)))).length;

    return totalCompleted > 0
        ? (thisWeekCompleted / totalCompleted) * 100
        : 0;
  }
}
