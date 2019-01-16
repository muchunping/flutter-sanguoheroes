import 'package:flutter/material.dart';

void main() => runApp(SanguoApp());

class SanguoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        body: SafeArea(child: TestApp()),
      ),
      theme: new ThemeData(
          highlightColor: Colors.transparent,
          //将点击高亮色设为透明
          splashColor: Colors.transparent,
          //将喷溅颜色设为透明
          bottomAppBarColor: new Color.fromRGBO(244, 245, 245, 1.0),
          //设置底部导航的背景色
          scaffoldBackgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
          //设置页面背景颜色
          primaryIconTheme: new IconThemeData(color: Colors.blue),
          //主要icon样式，如头部返回icon按钮
          indicatorColor: Colors.blue,
          //设置tab指示器颜色
          iconTheme: new IconThemeData(size: 18.0),
          //设置icon样式
          primaryTextTheme: new TextTheme(
              //设置文本样式
              title: new TextStyle(color: Colors.black, fontSize: 16.0))),
    );
  }
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  final double value;
  final double height;

  _LinearProgressIndicatorPainter({this.value, this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint);

    paint.color = Colors.blue;

    void drawBar(double x, double width) {
      if (width <= 0.0) return;

      double left = x;
      canvas.drawRect(Offset(left, 0.0) & Size(width, size.height), paint);
    }

    drawBar(0.0, value.clamp(0.0, 1.0) * size.width);
  }

  @override
  bool shouldRepaint(_LinearProgressIndicatorPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

class TestApp extends StatelessWidget {
  Widget _buildStatusBars() {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          color: Colors.green,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("ANCDEFG"),
              FlatButton(onPressed: null, child: Icon(Icons.airline_seat_flat))
            ],
          ),
        )),
        Container(
          height: 1,
          color: Colors.red,
        ),
        Container(
          width: double.infinity,
          height: 18,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
          ),
          child: CustomPaint(
            painter: _LinearProgressIndicatorPainter(value: 0.9),
          ),
        ),
        Container(
          height: 1,
          color: Colors.red,
        ),
        Container(
          width: double.infinity,
          height: 18,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
          ),
          child: CustomPaint(
            painter: _LinearProgressIndicatorPainter(value: 0.2),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                height: 84,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 64,
                          height: 64,
                          child: Image.asset("images/ic_launcher.png"),
                        ),
                        Container(
                          width: 1,
                          height: 64,
                          color: Colors.red,
                        ),
                        Expanded(
                          child: Container(
                            height: 64,
                            color: Colors.red,
                            child: _buildStatusBars(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                        ),
                        child: CustomPaint(
                          painter: _LinearProgressIndicatorPainter(value: 0.5),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border(
                    left: BorderSide(color: Colors.red),
                    top: BorderSide(color: Colors.red),
                    right: BorderSide(width: 0.5, color: Colors.red),
                    bottom: BorderSide(width: 0.5, color: Colors.red),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 84,
                child: Text("ABC"),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border(
                    left: BorderSide(width: 0.5, color: Colors.red),
                    top: BorderSide(color: Colors.red),
                    right: BorderSide(color: Colors.red),
                    bottom: BorderSide(width: 0.5, color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Text("ABC"),
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border(
                left: BorderSide(color: Colors.red),
                top: BorderSide(width: 0.5, color: Colors.red),
                right: BorderSide(color: Colors.red),
                bottom: BorderSide(width: 0.5, color: Colors.red),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 80,
          child: Text("ABC"),
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border(
              left: BorderSide(color: Colors.red),
              top: BorderSide(width: 0.5, color: Colors.red),
              right: BorderSide(color: Colors.red),
              bottom: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
