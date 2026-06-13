class UserProfileEntity {
  final String name;
  final String email;
  final String? imagePath;
  final DateTime accountCreatedAt;
  final int totalCompletedTasks;
  final int totalActiveTasks;

  const UserProfileEntity({
    required this.name,
    required this.email,
    this.imagePath,
    required this.accountCreatedAt,
    this.totalCompletedTasks = 0,
    this.totalActiveTasks = 0,
  });

  UserProfileEntity copyWith({
    String? name,
    String? email,
    String? imagePath,
    DateTime? accountCreatedAt,
    int? totalCompletedTasks,
    int? totalActiveTasks,
  }) {
    return UserProfileEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      accountCreatedAt: accountCreatedAt ?? this.accountCreatedAt,
      totalCompletedTasks: totalCompletedTasks ?? this.totalCompletedTasks,
      totalActiveTasks: totalActiveTasks ?? this.totalActiveTasks,
    );
  }

  factory UserProfileEntity.defaultProfile() {
    return UserProfileEntity(
      name: 'User',
      email: 'user@example.com',
      accountCreatedAt: DateTime.now(),
    );
  }
}
