class SubTaskEntity {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final int taskId;

  const SubTaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.taskId,
  });
}
