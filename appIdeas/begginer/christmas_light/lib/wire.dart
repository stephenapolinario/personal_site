import 'package:flutter/material.dart';

class SemiOval extends StatelessWidget {
  const SemiOval({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //1912
    return CustomPaint(
      painter: SemiOvalPainter(),
      child: SizedBox(
        width: screenWidth * 0.089,
        height: 37.0,
      ),
    );
  }
}

class SemiOvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(0.0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 2,
        size.width,
        size.height,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
