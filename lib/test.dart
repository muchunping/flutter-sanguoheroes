import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: MyApp(),
    ),
    routes: {
      "detail": (c) => NewPage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 100,
          height: 1000,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            index++;
            return Stack(
              children: <Widget>[
                Positioned(
                    left: 10,
                    top: 10,
                    right: 50,
                    bottom: 50,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("detail");
                        },
                        child: Text("Click $index")))
              ],
            );
          }),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("NewPage"));
  }
}
