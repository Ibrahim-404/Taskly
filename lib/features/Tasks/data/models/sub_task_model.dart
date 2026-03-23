class SubTaskModel {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final int taskId;
  SubTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.taskId,
  });
  factory SubTaskModel.fromMap(Map<String, dynamic> json) {
    return SubTaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['is_completed'],
      taskId: json['task_id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isDone,
      'task_id': taskId,
    };
  }
}
