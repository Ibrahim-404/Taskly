import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';
import 'package:tasks_manager/core/const/app_strings.dart';
import 'package:tasks_manager/core/theme/app_theme.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/bottom_navigation_bar_item_widget.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController mainScreenController = Get.find();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.navBarGradient(context),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -1),
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
          BottomNavigationBarItemWidget(
            index: 0,
            icon: Icons.home,
            label: AppStrings.home,
            mainScreenController: mainScreenController,
          ),
          BottomNavigationBarItemWidget(
            index: 1,
            icon: Icons.add_outlined,
            label: AppStrings.add,
            mainScreenController: mainScreenController,
          ),
          BottomNavigationBarItemWidget(
            index: 2,
            icon: Icons.search,
            label: AppStrings.search,
            mainScreenController: mainScreenController,
          ),
          BottomNavigationBarItemWidget(
            index: 3,
            icon: Icons.analytics,
            label: AppStrings.analytics,
            mainScreenController: mainScreenController,
          ),
        ],
      ),
    );
  }
}
