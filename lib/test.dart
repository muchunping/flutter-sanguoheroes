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

int index = -1;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("YQB:MyApp show");
    index = -1;
    return Include();
  }
}

class Include extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("YQB:Include show");
    return HomePage(context);
  }

}

class HomePage extends StatelessWidget {
  final BuildContext context1;
  HomePage(this.context1);

  @override
  Widget build(BuildContext context) {
    print("YQB:HomePage show");
    index++;
    print("YQB:index++");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              print("YQB:push detail");
              Navigator.of(context).pushNamed("detail");
            },
            child: Text("NO DIALOG $index"),
          ),
          FlatButton(
            onPressed: () {
              print("YQB:showDialog");
              showDialog(
                  context: context1,
                  builder: (BuildContext context) {
                    return SimpleDialog(title: Text("选择"), children: [
                      SimpleDialogOption(
                        child: Text("选项1"),
                        onPressed: () {
                          print("YQB:dialog.pop and push detail");
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed("detail");
                        },
                      )
                    ]);
                  });
            },
            child: Text("DIALOG $index"),
          )
        ],
      ),
    );
  }

}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("YQB:detail page show");
    return Scaffold(
      body: Center(child: Text("NewPage")),
    );
  }
}
