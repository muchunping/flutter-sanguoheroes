import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      routes: {
        "home": (c) => HomePage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 10),
        lowerBound: 0,
        upperBound: 100)
      ..addListener(() {
        setState(() => {});
      });
    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var windowSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: SafeArea(
            child: Container(
                color: Colors.lightBlueAccent,
                width: windowSize.width,
                height: windowSize.height,
                child: Stack(
                  children: <Widget>[
                    Container(alignment: Alignment.center, child: Text("ABC")),
                    _buildProgressIndicator(),
                  ],
                ))),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: _controller.value * 3.52 + 8),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "${_controller.value.toInt()}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  width: 24,
                  height: 20,
                  decoration: ShapeDecoration(
                      color: Colors.blueAccent, shape: CustomShape()))),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 4),
            child: EventProgressIndicator(
              _controller.value / 100,
            ),
          ),
          Center(
            child: Text("启动完成"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
        ]);
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
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

class EventProgressIndicator extends ProgressIndicator {
  EventProgressIndicator(double value) : super(value: value);

  @override
  State<EventProgressIndicator> createState() {
    return EventProgressState();
  }
}

class EventProgressState extends State<EventProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 10,
      ),
      child: CustomPaint(
        painter: _EventProgressIndicatorPainter(widget.value),
      ),
    );
  }
}

class _EventProgressIndicatorPainter extends CustomPainter {
  final double value;
  final List<ProgressEvent> events = [
    ProgressEvent("下载插件资源", 20),
    ProgressEvent("解压资源", 30),
    ProgressEvent("校验资源", 30),
    ProgressEvent("运行插件", 20),
  ];
  double totalCost = 0;

  _EventProgressIndicatorPainter(this.value) {
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
}
