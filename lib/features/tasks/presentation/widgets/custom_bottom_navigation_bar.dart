import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/core/controller/main_screen_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController mainScreenController = Get.find();
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
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
            _buildItem(0, Icons.home, "Home", mainScreenController),
            _buildItem(1, Icons.add_outlined, "Add", mainScreenController),
            _buildItem(2, Icons.search, "Search", mainScreenController),
            _buildItem(3, Icons.analytics, "Analytics", mainScreenController),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    int index,
    IconData icon,
    String label,
    MainScreenController mainScreenController,
  ) {
    final isSelected = mainScreenController.selectedIndex == index;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              mainScreenController.updateSelectedIndex(index);
            },
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                final scale = 1 + (0.2 * value);
                final translateY = -10 * value;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, translateY),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.6),
                                      blurRadius: 12 * value,
                                      offset: const Offset(0, 4),
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? Colors.white : Colors.white70,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
