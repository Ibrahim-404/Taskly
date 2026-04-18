import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/Core/controller/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController mainScreenController = Get.put(
    MainScreenController(),
  );
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),

      body: Column(
        children: [
          CustomHeader(),
          SizedBox(height: 40),
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

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final MainScreenController mainScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
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
            buildItem(0, Icons.home, "Home", mainScreenController),
            buildItem(1, Icons.search, "Search", mainScreenController),
            buildItem(2, Icons.person, "Profile", mainScreenController),
          ],
        ),
      ),
    );
  }
}

class CustomWavePaint extends CustomPainter {
  final double animationValue;

  CustomWavePaint(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final gradient = LinearGradient(colors: [Colors.blue, Colors.purple]);

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final path = Path();

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height + 19,
      size.width * 0.5,
      size.height - 25,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 90,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomWavePaint oldDelegate) {
    // return oldDelegate.animationValue != animationValue;
    return true;
  }
}

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(double.infinity, 200),
                painter: CustomWavePaint(_controller.value),
              );
            },
          ),

          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // 👤 Profile Image
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage("https://i.pravatar.cc/300"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 12),

                // 📝 Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Ibrahim 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildItem(
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
            duration: Duration(milliseconds: 300),
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
                                    offset: Offset(0, 4),
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
                  SizedBox(height: 4),
                  AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      label,
                      style: TextStyle(
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
