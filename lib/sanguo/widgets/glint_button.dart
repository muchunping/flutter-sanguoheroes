import 'package:flutter/material.dart';

class TestWidgets extends StatefulWidget {
  @override
  State<TestWidgets> createState() {
    return TestState();
  }
}

class TestState extends State<TestWidgets> with SingleTickerProviderStateMixin {
  AnimationController controller;
  double radius = 2.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    controller.addListener(() {
      setState(() {
        radius = 20.0 * controller.value;
      });
    });
    controller.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        controller.reverse();
      } else if (state == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.cyanAccent,
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                  color: Colors.cyanAccent,
                  offset: Offset.zero,
                  blurRadius: radius,
                  spreadRadius: 0.0)
            ],
            borderRadius: BorderRadius.circular(10.0)),
        width: 100,
        height: 200,
        child: Text(
          "Text",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
