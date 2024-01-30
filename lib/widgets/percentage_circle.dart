import 'package:flutter/material.dart';
import 'dart:math';

class PercentageCircle extends StatelessWidget {
  final double percentage;

  const PercentageCircle({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 120,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8), // Shadow color
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: CustomPaint(
            painter: PercentageCirclePainter(percentage: percentage),
            child: Center(
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  color: Color(0xFFFF6C37),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ));
  }
}

class PercentageCirclePainter extends CustomPainter {
  final double percentage;

  PercentageCirclePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 360 * percentage;
    final arcPaint = Paint()
      ..color = const Color(0xFFFF6C37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (pi / 180),
      sweepAngle * (pi / 180),
      false,
      arcPaint,
    );

    // final borderPaint = Paint()
    //   ..color = const Color(0xFFFF6C37)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2.0;
    // canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Percentage Circle')),
        body: const Center(
          child: PercentageCircle(percentage: 0.09), // Example with 9%
        ),
      ),
    ),
  );
}
