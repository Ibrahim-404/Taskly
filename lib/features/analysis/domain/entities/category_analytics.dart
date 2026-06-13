class CategoryAnalytics {
  final String categoryName;
  final int totalTasks;
  final int completedTasks;

  const CategoryAnalytics({
    required this.categoryName,
    required this.totalTasks,
    required this.completedTasks,
  });

  double get completionPercentage =>
      totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;

  int get pendingTasks => totalTasks - completedTasks;
}
