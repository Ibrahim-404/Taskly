import 'package:tasks_manager/features/profile/domain/entities/user_profile_entity.dart';
import 'package:tasks_manager/features/profile/domain/repo/profile_repo.dart';

class GetProfile {
  final ProfileRepo repo;
  GetProfile(this.repo);

  Future<UserProfileEntity> call() async {
    return await repo.getProfile();
  }
}
