import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tasks_manager/Core/controller/base_controller.dart';

class MainScreenController extends BaseController {
  final List<Widget> widgetOptions = <Widget>[
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
