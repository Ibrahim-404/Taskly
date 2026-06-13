import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/core/enums/view_state.dart';
import 'package:tasks_manager/features/profile/domain/entities/user_profile_entity.dart';
import 'package:tasks_manager/features/profile/domain/usecases/get_profile.dart';
import 'package:tasks_manager/features/profile/domain/usecases/update_profile_name.dart';
import 'package:tasks_manager/features/profile/domain/usecases/update_profile_picture.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';

class ProfileController extends BaseController {
  final GetProfile getProfile;
  final UpdateProfileName updateProfileName;
  final UpdateProfilePicture updateProfilePicture;

  ProfileController({
    required this.getProfile,
    required this.updateProfileName,
    required this.updateProfilePicture,
  });

  final profile = Rxn<UserProfileEntity>();
  final isEditingName = false.obs;
  final nameController = TextEditingController();
  final tasks = <TaskEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> loadProfile() async {
    setState(ViewState.busy);
    try {
      final result = await getProfile();
      profile.value = result;
      nameController.text = result.name;
      setState(ViewState.idle);
    } catch (e) {
      setState(ViewState.error, errorMessage: e.toString());
    }
  }

  Future<void> updateName(String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty || trimmed.length < 3) return;
    if (trimmed.length > 50) return;

    try {
      await updateProfileName(trimmed);
      profile.value = profile.value?.copyWith(name: trimmed);
      nameController.text = trimmed;
      isEditingName.value = false;
    } catch (e) {
      setState(ViewState.error, errorMessage: e.toString());
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (picked == null) return;

      await updateProfilePicture(picked.path);
      profile.value = profile.value?.copyWith(imagePath: picked.path);
    } catch (e) {
      setState(ViewState.error, errorMessage: e.toString());
    }
  }

  Future<void> removeImage() async {
    try {
      await updateProfilePicture(null);
      profile.value = profile.value?.copyWith(imagePath: null);
    } catch (e) {
      setState(ViewState.error, errorMessage: e.toString());
    }
  }

  int get totalActiveTasks {
    if (!Get.isRegistered<TaskController>()) return 0;
    final tc = Get.find<TaskController>();
    final now = DateTime.now();
    return tc.tasks.where((t) {
      if (t.isDone) return false;
      if (t.date.isBefore(now)) return false;
      return true;
    }).length;
  }

  int get totalCompletedTasks {
    if (!Get.isRegistered<TaskController>()) return 0;
    final tc = Get.find<TaskController>();
    return tc.tasks.where((t) => t.isDone).length;
  }

  String get accountAge {
    final created = profile.value?.accountCreatedAt;
    if (created == null) return 'Today';
    final diff = DateTime.now().difference(created);
    if (diff.inDays < 30) return '${diff.inDays} days';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} months';
    return '${(diff.inDays / 365).floor()} years';
  }
}
