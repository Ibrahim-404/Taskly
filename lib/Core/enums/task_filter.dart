enum TaskFilter {
  all('All Tasks'),
  completed('Completed'),
  inProgress('In Progress'),
  highPriority('High Priority'),
  dueSoon('Due Soon'),
  overdue('Overdue');

  final String label;
  const TaskFilter(this.label);
}
