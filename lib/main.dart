import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/widgets/glint_button.dart';
import 'package:sanguo_heroes/sanguo/widgets/progress_bar_samples.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    return TestWidgets();
    return GradientCircularProgressRoute();
  }
}


