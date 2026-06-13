import 'package:tasks_manager/features/profile/domain/repo/profile_repo.dart';

class UpdateProfileName {
  final ProfileRepo repo;
  UpdateProfileName(this.repo);

  Future<void> call(String name) async {
    return await repo.updateName(name);
  }
}
