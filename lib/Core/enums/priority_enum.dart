enum TaskPriority {
  low(0, 'low'),
  medium(1, 'medium'),
  high(2, 'high');

  final int value;
  final String name;

  const TaskPriority(this.value, this.name);

  static TaskPriority fromString(String? priority) {
    if (priority == null) return TaskPriority.low;
    switch (priority.toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      default:
        return TaskPriority.low;
    }
  }

  static TaskPriority fromValue(int? value) {
    switch (value) {
      case 0:
        return TaskPriority.low;
      case 1:
        return TaskPriority.medium;
      case 2:
        return TaskPriority.high;
      default:
        return TaskPriority.low;
    }
  }
}
