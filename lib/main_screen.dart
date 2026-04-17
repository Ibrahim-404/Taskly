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
          // CustomHeader(),
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
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              isSelected: mainScreenController.selectedIndex == 0,
              onPressed: () {
                HapticFeedback.lightImpact();
                mainScreenController.updateSelectedIndex(0);
              },
              icon: Icon(Icons.home_outlined, color: Colors.white),
            ),
            IconButton(
              isSelected: mainScreenController.selectedIndex == 1,
              onPressed: () {
                HapticFeedback.lightImpact();
                mainScreenController.updateSelectedIndex(1);
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              isSelected: mainScreenController.selectedIndex == 2,
              onPressed: () {
                HapticFeedback.lightImpact();
                mainScreenController.updateSelectedIndex(2);
              },
              icon: Icon(Icons.person, color: Colors.white),
            ),
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

    double waveHeight = 20 * animationValue;

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 40 + waveHeight,
      size.width * 0.5,
      size.height - 40,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 80 - waveHeight,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomWavePaint oldDelegate) {
    return oldDelegate.animationValue != animationValue;
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
            bottom: -30,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
            ),
          ),

          Positioned(
            top: 50,
            child: Text(
              "Welcome Ibrahim 👋",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
