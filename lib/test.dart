import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ABC"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Expanded(child: Text("One")),
            Expanded(
                flex: 2,
                child: Text(
                  "Two",
                  style: TextStyle(fontSize: 54),
                )),
            Expanded(child: Text("Three"))
          ],
        ),
      ),
    );
  }
}
