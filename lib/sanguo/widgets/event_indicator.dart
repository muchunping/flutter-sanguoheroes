import 'package:flutter/material.dart';

class EventProgressIndicator extends ProgressIndicator {
  final List<ProgressEvent> events;

  EventProgressIndicator(this.events, double value) : super(value: value);

  @override
  State<EventProgressIndicator> createState() {
    return EventProgressState();
  }
}

class EventProgressState extends State<EventProgressIndicator> {
  double get totalCost {
    var cost = 0.0;
    for (var event in widget.events) {
      cost += event.weight;
    }
    return cost;
  }

  ProgressEvent get currentEvent {
    var cost = 0.0;
    var totalCost = this.totalCost;
    for (var event in widget.events) {
      if (widget.value < (cost += event.weight) / totalCost * 100) {
        return event;
      }
    }
    return ProgressEvent.one;
  }

  @override
  Widget build(BuildContext context) {
    return _buildIndicator();
  }

  Widget _buildIndicator() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: widget.value * 3.52 + 8),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "${widget.value.toInt()}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  width: 24,
                  height: 20,
                  decoration: ShapeDecoration(
                      color: Colors.blueAccent, shape: CustomShape()))),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 4),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 10,
              ),
              child: CustomPaint(
                painter: _EventProgressIndicatorPainter(
                    widget.events, widget.value / 100),
              ),
            ),
          ),
          Center(
            child: Text(currentEvent.name),
          ),
        ]);
  }
}

class CustomShape extends ShapeBorder {
  const CustomShape({
    this.side = BorderSide.none,
  }) : assert(side != null);

  /// The style of this border.
  final BorderSide side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(1);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return new Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return new Path()
      ..moveTo(rect.left, rect.top)
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.right, rect.top + rect.height * 0.75)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy)
      ..lineTo(rect.left, rect.top + rect.height * 0.75)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return CustomShape(
      side: side.scale(t),
    );
  }
}

class _EventProgressIndicatorPainter extends CustomPainter {
  final double value;
  final List<ProgressEvent> events;
  double totalCost = 0;

  _EventProgressIndicatorPainter(this.events, this.value) {
    events.insert(0, ProgressEvent.zero);
    events.forEach((f) {
      totalCost += f.weight;
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    void drawBar(Paint paint) {
      canvas.drawRect(
          Offset.zero.translate(0, 2) & Size(size.width, size.height - 4),
          paint);
      var cost = 0.0;
      events.forEach((f) {
        cost += f.weight;
        canvas.drawCircle(
            Offset(size.width * cost / totalCost, size.height / 2),
            size.height / 2,
            paint);
      });
    }

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    drawBar(paint);
    paint.color = Colors.blue;
    canvas.save();
    canvas.clipRect(
        Offset.zero & Size(value.clamp(0.0, 1.0) * size.width, size.height));
    drawBar(paint);
    canvas.restore();

    canvas.drawCircle(Offset(0, size.height / 2), size.height / 2, paint);
    if (value.clamp(0.0, 1.0) >= 1.0) {
      canvas.drawCircle(
          Offset(size.width, size.height / 2), size.height / 2, paint);
    }
  }

  @override
  bool shouldRepaint(_EventProgressIndicatorPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

class ProgressEvent {
  final double weight;
  final String name;

  const ProgressEvent(this.name, this.weight);

  static const ProgressEvent zero = ProgressEvent("开始加载", 0);
  static const ProgressEvent one = ProgressEvent("加载完成", 100);
}
