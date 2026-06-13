import 'package:tasks_manager/features/profile/domain/repo/profile_repo.dart';

class UpdateProfilePicture {
  final ProfileRepo repo;
  UpdateProfilePicture(this.repo);

  Future<void> call(String? imagePath) async {
    return await repo.updateImagePath(imagePath);
  }
}
