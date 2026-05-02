import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/bottom_navigation_bar_item_widget.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController mainScreenController = Get.find();
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.blue, AppColors.purple]),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black26,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationBarItemWidget(index: 0, icon: Icons.home, label: "Home", mainScreenController: mainScreenController),
            BottomNavigationBarItemWidget(index: 1, icon: Icons.add_outlined, label: "Add", mainScreenController: mainScreenController),
            BottomNavigationBarItemWidget(index: 2, icon: Icons.search, label: "Search", mainScreenController: mainScreenController),
            BottomNavigationBarItemWidget(index: 3, icon: Icons.analytics, label: "Analytics", mainScreenController: mainScreenController),
          ],
        ),
      ),
    );
  }
}
