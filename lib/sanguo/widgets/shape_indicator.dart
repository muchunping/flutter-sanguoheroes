import 'package:flutter/material.dart';
import 'dart:math' as Math;

main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.white70,
            child: ValueShapeIndicator(
              values: [50, 60, 50, 40, 55, 60],
            ),
          ),
        ),
      ),
    ));

class ValueShapeIndicator extends StatelessWidget {
  final List<double> values;

  const ValueShapeIndicator({Key key, this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ValueShapeIndicatorPainter(values),
    );
  }
}

class _ValueShapeIndicatorPainter extends CustomPainter {
  final List<double> values;

  _ValueShapeIndicatorPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var radius = Math.min(size.width, size.height) / 2;
    var center = size.center(Offset.zero);
    var degree = Math.pi * 2 / values.length;
    var path = Path();
    for (int index = 0; index < values.length; index++) {
      var totalDegree = Math.pi * 1.5 - degree / 2 - index * degree;
      var dx = Math.cos(totalDegree);
      var dy = Math.sin(totalDegree);
      canvas.drawLine(
          center, center.translate(dx * radius, -dy * radius), paint);
      canvas.drawCircle(
          center.translate(dx * values[index], -dy * values[index]), 3, paint);
      if (index == 0) {
        path.moveTo(
            center.dx + dx * values[index], center.dy + -dy * values[index]);
      } else {
        path.lineTo(
            center.dx + dx * values[index], center.dy + -dy * values[index]);
      }
    }
    path.close();
    paint
      ..color = Colors.cyanAccent.withAlpha(200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ValueShapeIndicatorPainter oldDelegate) {
    if (this.values.length != oldDelegate.values.length) {
      return true;
    }
    for (int i = 0; i < this.values.length; i++) {
      if (this.values[i] != oldDelegate.values[i]) {
        return true;
      }
    }
    return false;
  }
}
