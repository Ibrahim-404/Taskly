import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/core/controller/base_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_show_dialog_for_add_new_Task.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task/build_all_tasks.dart';

class MainScreenController extends BaseController {
  final List<Widget> widgetOptions = <Widget>[
    // TaskMainScreen(),
    BuildAllTasks(),
    CustomShowDialogForAddNewTask(),
    Text('Profile Screen'),
    Text('Analytics Screen'),
  ];

  var _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  void updateSelectedIndex(int index) {
    _selectedIndex.value = index;
    update();
  }
}
