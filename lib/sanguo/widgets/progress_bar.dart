import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 20), //指定画布大小
        painter: MyPainter(value: 0.5),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(
      {this.backgroundColor = Colors.orange,
      this.foregroundColor = Colors.pinkAccent,
      @required this.value})
      : assert(value >= 0);
  Color backgroundColor;
  Color foregroundColor;
  double value;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.value != this.value;
  }
}
