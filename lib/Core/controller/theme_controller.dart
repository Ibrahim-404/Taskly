import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const _key = 'theme_mode';

  final _selectedMode = ThemeMode.system.obs;

  ThemeMode get selectedMode => _selectedMode.value;
  bool get isDarkMode => Get.isDarkMode;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_key);
    if (saved != null) {
      _selectedMode.value = ThemeMode.values[saved];
      Get.changeThemeMode(_selectedMode.value);
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    _selectedMode.value = mode;
    Get.changeThemeMode(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
  }
}
