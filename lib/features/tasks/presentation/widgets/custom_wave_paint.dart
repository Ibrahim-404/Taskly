import 'package:flutter/material.dart';

class CustomWavePaint extends CustomPainter {
  final double animationValue;

  CustomWavePaint(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final gradient = const LinearGradient(colors: [Colors.blue, Colors.purple]);

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final path = Path();

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height + 5,
      size.width * 0.5,
      size.height - 70,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 150,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomWavePaint oldDelegate) {
    return true;
  }
}
