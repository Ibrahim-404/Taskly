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
  factory SubTaskEntity.skeleton() {
    return const SubTaskEntity(
      id: 0,
      title: 'Loading...',
      description: 'Loading description...',
      isDone: false,
      taskId: 0,
    );
  }
}
