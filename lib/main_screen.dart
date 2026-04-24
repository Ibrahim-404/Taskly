import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_header.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController mainScreenController = Get.put(
    MainScreenController(),
  );

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Column(
        children: [
          const CustomHeader(),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => mainScreenController
                  .widgetOptions[mainScreenController.selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
