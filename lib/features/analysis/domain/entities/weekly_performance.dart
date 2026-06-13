class WeeklyPerformance {
  final int lastWeekCompleted;
  final int thisWeekCompleted;

  const WeeklyPerformance({
    required this.lastWeekCompleted,
    required this.thisWeekCompleted,
  });

  double get changePercentage => lastWeekCompleted > 0
      ? ((thisWeekCompleted - lastWeekCompleted) / lastWeekCompleted) * 100
      : thisWeekCompleted > 0
          ? 100
          : 0;

  bool get isImprovement => thisWeekCompleted >= lastWeekCompleted;
}
