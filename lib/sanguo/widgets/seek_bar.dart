import 'package:flutter/material.dart';

main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        body: Center(
          child: SeekBar(),
        ),
      ),
    ));

class SeekBar extends StatefulWidget {
  final List<String> seeks;

  const SeekBar({Key key, this.seeks}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeekBarState();
  }
}

class SeekBarState extends State<SeekBar> {
  var position = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (v) {
        print("onTapDown: ${v.globalPosition.dx}");
        setState(() {
          position = v.globalPosition.dx;
        });
      },
      onTapUp: (v) => print("onTapUp: ${v.globalPosition.dx}"),
      onPanDown: (v) => print("onPanDown: ${v.globalPosition.dx}"),
      onPanStart: (v) => print("onPanStart: ${v.globalPosition.dx}"),
      onPanUpdate: (v) {
        print("onPanUpdate: ${v.globalPosition.dx}");
        setState(() {
          position = v.globalPosition.dx;
        });
      },
      onPanEnd: (v) => print("onPanEnd: ${v.primaryVelocity}"),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: 30,
        ),
        child: CustomPaint(
          painter: _SeekBarPainter(position, widget.seeks),
        ),
      ),
    );
  }
}

class _SeekBarPainter extends CustomPainter {
  final double value;
  final List<String> seeks;

  _SeekBarPainter(this.value, this.seeks);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(15)),
        paint);

    var cw = size.width / seeks.length;
    var translateX = 0.0;
    for (var seek in seeks) {
      var textPainter = TextPainter(
          text: TextSpan(
              text: seek, style: TextStyle(color: Colors.black.withAlpha(100))),
          textDirection: TextDirection.ltr);
      textPainter.layout();
      var tw = textPainter.width;
      var th = textPainter.height;
      var offset = Offset((cw - tw) / 2, (size.height - th) / 2)
          .translate(translateX, 0.0);

      textPainter.paint(canvas, (offset & size).topLeft);
      translateX += cw;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.blueAccent;
    var rect = Offset.zero & Size(cw - 4, size.height - 4);
    var cell = ((value - cw / 2) / cw).round();
    cell = cell < 0 ? 0 : cell;
    rect = rect.translate(cw * cell + 2, 2);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(15)), paint);
    var textPainter = TextPainter(
        text:
            TextSpan(text: seeks[cell], style: TextStyle(color: Colors.white)),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var tw = textPainter.width;
    var th = textPainter.height;
    var offset =
        Offset((cw - tw) / 2, (size.height - th) / 2).translate(cw * cell, 0.0);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_SeekBarPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
