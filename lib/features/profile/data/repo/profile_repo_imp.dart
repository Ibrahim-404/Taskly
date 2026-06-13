import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_manager/features/profile/domain/entities/user_profile_entity.dart';
import 'package:tasks_manager/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImp implements ProfileRepo {
  static const _keyName = 'profile_name';
  static const _keyEmail = 'profile_email';
  static const _keyImagePath = 'profile_image_path';
  static const _keyCreatedAt = 'profile_created_at';

  @override
  Future<UserProfileEntity> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName) ?? 'User';
    final email = prefs.getString(_keyEmail) ?? 'user@example.com';
    final imagePath = prefs.getString(_keyImagePath);
    final createdAtStr = prefs.getString(_keyCreatedAt);

    DateTime createdAt;
    if (createdAtStr != null) {
      createdAt = DateTime.parse(createdAtStr);
    } else {
      createdAt = DateTime.now();
      await prefs.setString(_keyCreatedAt, createdAt.toIso8601String());
    }

    return UserProfileEntity(
      name: name,
      email: email,
      imagePath: imagePath,
      accountCreatedAt: createdAt,
    );
  }

  @override
  Future<void> updateName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  @override
  Future<void> updateEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  @override
  Future<void> updateImagePath(String? imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    if (imagePath != null) {
      await prefs.setString(_keyImagePath, imagePath);
    } else {
      await prefs.remove(_keyImagePath);
    }
  }
}
