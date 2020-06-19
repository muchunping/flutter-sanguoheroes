import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final Direction direction;
  final double value;

  const ProgressBar(
      {@required this.value,
      this.width,
      this.height,
      this.direction = Direction.ltr});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height), //指定画布大小
        painter: MyPainter(value: value, direction: direction),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Direction direction;

  MyPainter(
      {this.backgroundColor = Colors.grey,
      this.foregroundColor = Colors.orange,
      @required this.value,
      this.direction})
      : assert(value >= 0) {
    value = value > 1 ? 1 : value;
  }

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

    paint.color = foregroundColor;
    var offset;
    var pSize;
    if (direction == Direction.ltr) {
      offset = Offset.zero;
      pSize = Size(size.width * value, size.height);
    } else if (direction == Direction.btt) {
      offset = Offset(0, size.height * (1 - value));
      pSize = Size(size.width, size.height * value);
    }
    canvas.drawRect(offset & pSize, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.value != this.value;
  }
}

enum Direction {
  rtl,
  ltr,
  ttb,
  btt,
}
