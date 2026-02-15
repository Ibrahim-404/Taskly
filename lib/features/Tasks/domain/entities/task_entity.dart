class TaskEntity {
  final int id;
  final String title;
  final String description;
  final String date;
  final bool isDone;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });
}