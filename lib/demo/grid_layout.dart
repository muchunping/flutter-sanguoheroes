import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GridLayout"),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GridLayout(children: [
      _buildSimpleChild(0, 100, 150, Colors.red),
      _buildSimpleChild(1, 100, 130, Colors.green),
      _buildSimpleChild(2, 100, 150, Colors.yellow),
      _buildSimpleChild(3, 100, 140, Colors.pinkAccent),
      _buildSimpleChild(4, 100, 50, Colors.amber),
      _buildSimpleChild(5, 100, 140, Colors.blue),
      _buildSimpleChild(6, 100, 150, Colors.brown),
      _buildSimpleChild(7, 100, 140, Colors.deepOrange),
      _buildSimpleChild(8, 100, 140, Colors.deepPurple),
      _buildSimpleChild(9, 100, 50, Colors.amber),
      _buildSimpleChild(10, 100, 140, Colors.blue),
      _buildSimpleChild(11, 100, 150, Colors.brown),
      _buildSimpleChild(12, 100, 140, Colors.deepOrange),
      _buildSimpleChild(13, 100, 140, Colors.deepPurple),
    ]);
  }

  Widget _buildSimpleChild(
      Object id, double width, double height, Color color) {
    return LayoutId(
      id: id,
      child: Container(
        height: height,
        color: color,
        child: Center(
          child: Text("$id"),
        ),
      ),
    );
  }
}

class GridLayout extends StatelessWidget {
  final List<Widget> children;
  final double horizontalSpace;
  final double verticalSpace;

  GridLayout(
      {@required this.children, this.horizontalSpace, this.verticalSpace});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CustomMultiChildLayout(
          delegate: GridLayoutDelegate(children),
          children: children,
        )
      ],
    );
  }
}

class GridLayoutDelegate extends MultiChildLayoutDelegate {
  final double horizontalSpace;
  final double verticalSpace;
  Map<int, Size> sizeMap = Map();

  final children;

  GridLayoutDelegate(this.children, {this.horizontalSpace = 4, this.verticalSpace = 4});

  @override
  void performLayout(Size size) {
    double width = (size.width - horizontalSpace) / 2;
    var itemConstraints = BoxConstraints(
        minWidth: width, maxWidth: width, maxHeight: size.height);
    var index = 0;
    double dxL = 0, dxR = width + horizontalSpace;
    double dyL = 4, dyR = 4;
    while (hasChild(index)) {
      var _itemSizes = layoutChild(index, itemConstraints);

      var dx = math.min(dyL, dyR) == dyL ? dxL : dxR;
      var dy = math.min(dyL, dyR) == dyL ? dyL : dyR;
      positionChild(index, Offset(dx, dy));
      if (math.min(dyL, dyR) == dyL) {
        dyL += _itemSizes.height + verticalSpace;
      } else {
        dyR += _itemSizes.height + verticalSpace;
      }
      index++;
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    double height;

    if (constraints.maxHeight == double.infinity) {
      height = 2000;
    } else {
      height = constraints.maxHeight;
    }
    return Size.fromHeight(double.infinity);
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
