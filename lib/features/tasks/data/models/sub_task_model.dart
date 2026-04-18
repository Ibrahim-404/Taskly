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
      isDone: json['is_completed'] == 1 || json['is_completed'] == true,
      taskId: json['task_id'],
    );
  }
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'is_completed': isDone ? 1 : 0,
      'task_id': taskId,
    };
    if (id != 0) {
      map['id'] = id;
    }
    return map;
  }
}
