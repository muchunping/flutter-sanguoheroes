import 'package:flutter/material.dart';

class LocationIndicator extends StatelessWidget {
  final double angle;
  final double x, y;
  final double width, height;

  LocationIndicator(this.angle, this.x, this.y, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _LocationIndicatorPainter(angle, x, y),
    );
  }
}

class _LocationIndicatorPainter extends CustomPainter {
  final double angle;
  final double x, y;

  _LocationIndicatorPainter(this.angle, this.x, this.y);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.1, size.width * 0.8,
            size.height * 0.8),
        paint);
    paint.color = Colors.yellowAccent;
    canvas.drawCircle(Offset(x, y), 2, paint);
  }

  @override
  bool shouldRepaint(_LocationIndicatorPainter oldDelegate) {
    return this.angle == oldDelegate.angle &&
        this.x == oldDelegate.x &&
        this.y == oldDelegate.y;
  }
}
