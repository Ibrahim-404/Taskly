import 'package:tasks_manager/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepo {
  Future<UserProfileEntity> getProfile();
  Future<void> updateName(String name);
  Future<void> updateEmail(String email);
  Future<void> updateImagePath(String? imagePath);
}
