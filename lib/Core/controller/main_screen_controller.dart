import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/task_main_screen.dart';

class MainScreenController extends BaseController {
  final List<Widget> widgetOptions = <Widget>[
    // TaskMainScreen(),
    Text('Home Screen'),
    Text('Search Screen'),
    Text('Profile Screen'),
  ];

  var _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  void updateSelectedIndex(int index) {
    _selectedIndex.value = index;
    update();
  }
}
