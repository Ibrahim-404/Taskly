import 'package:tasks_manager/features/profile/domain/repo/profile_repo.dart';

class UpdateProfileEmail {
  final ProfileRepo repo;
  UpdateProfileEmail(this.repo);

  Future<void> call(String email) async {
    return await repo.updateEmail(email);
  }
}
