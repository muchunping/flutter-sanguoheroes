import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sanguoheroes/sanguo/index.dart';
import 'package:sanguoheroes/sanguo/widgets/progress_bar.dart';
import 'dart:math';

main() => runApp(SkillPage());

class SkillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomPaint(
            painter: SkillPlate(0),
            size: Size(360 * scaleX, 200 * scaleX),
          ),
        ),
        appBar: AppBar(
          title: Text("技能树"),
        ),
      ),
    );
  }
}

class SkillPlate extends CustomPainter {
  final double angle;

  SkillPlate(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.white, BlendMode.srcOver);
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    var radius = size.height > size.width ? size.width / 2 : size.height / 2;
//    canvas.drawCircle(size.center(Offset.zero), radius, paint);
    Offset center = size.center(Offset.zero);
    Rect rect = Rect.fromCircle(center: center, radius: radius);
//    Path path1 = Path()
//      ..moveTo(center.dx, center.dy)
//      ..relativeLineTo(0, radius)
//      ..arcTo(rect, pi * 0.5, pi * 0.2, true)
//      ..lineTo(center.dx, center.dy);
//    Path path2 = Path()
//      ..addOval(rect);
//    canvas.drawPath(path1, paint);
//    canvas.drawPath(path2, paint);
    canvas.saveLayer(null, paint);
    canvas.drawCircle(center, radius, paint);
    paint
      ..blendMode = BlendMode.srcIn
      ..color = Colors.amber;
    canvas.saveLayer(null, paint);
    canvas.drawCircle(center.translate(100, 20), radius / 2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(SkillPlate oldDelegate) {
    return oldDelegate.angle != this.angle;
  }
}

class SkillTree extends StatefulWidget {
  @override
  _SkillTreeState createState() => _SkillTreeState();
}

class _SkillTreeState extends State<SkillTree> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 22 * scaleX,
                  height: 250 * scaleX,
                  child: ProgressBar(
                    value: progress / 32,
                    width: 20 * scaleX,
                    height: 248 * scaleX,
                    direction: Direction.btt,
                  ),
                ),
                Ink(
                  color: Colors.purple,
                  width: 28 * scaleX,
                  height: 28 * scaleX,
                  child: InkWell(
                    onTap: () {
                      progress++;
                      setState(() {});
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
          ],
        ),
      ),
    );
  }
}

class SkillGridCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 56 * scaleX,
        height: 56 * scaleX,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [Colors.black26, Colors.black38, Colors.black54]),
          border: Border.all(color: Colors.black87),
        ));
  }
}
