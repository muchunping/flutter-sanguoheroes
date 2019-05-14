import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/models/world_context.dart';
import 'package:sanguo_heroes/sanguo/widgets/event_indicator.dart';
import 'package:sanguo_heroes/sanguo/widgets/shimmer.dart';

main() => runApp(MyApp());

const Size uxSize = Size(360, 640);
final MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
final scaleX =
        (mediaQuery.size.width - mediaQuery.padding.horizontal) / uxSize.width,
    scaleY =
        (mediaQuery.size.height - mediaQuery.padding.vertical) / uxSize.height;
WorldContext worldContext;

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
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    worldContext = WorldContext()
      ..loadResource(DefaultAssetBundle.of(context), (progress) {
        this.progress = progress;
        setState(() => {});
        if (progress >= 100) {
          Navigator.of(context).pushReplacementNamed("home");
        }
      });
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: SafeArea(
            child: Container(
                color: Colors.lightBlueAccent,
                width: 360 * scaleX,
                height: 640 * scaleY,
                child: Stack(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Shimmer(
                          child: Text(
                            "插\n线\n板",
                            style: TextStyle(fontSize: 36),
                          ),
                          period: Duration(seconds: 2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.yellow,
                              Colors.blue,
                              Colors.yellow,
                              Colors.red,
                            ],
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: EventProgressIndicator(
                        progress,
                        listener: (e) {
                          print(e.name);
                        },
                        events: [
                          ProgressEvent("下载插件资源", 10),
                          ProgressEvent("解压资源", 50),
                          ProgressEvent("安装中..", 50),
                          ProgressEvent("校验资源", 30),
                          ProgressEvent("运行插件", 20),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  final Widget divider1 = Divider(color: Colors.blue, height: 1);
  final Widget divider2 = Divider(color: Colors.green, height: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: 360 * scaleX,
                height: 100 * scaleY,
                child: Text("header"),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueGrey)),
              ),
              Container(
                width: 360 * scaleX,
                height: 540 * scaleY,
                color: Colors.yellow.shade50,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var item = worldContext.sceneList[index];
                      return ListTile(
                        leading: Icon(Icons.access_alarm),
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return index % 2 == 0 ? divider1 : divider2;
                    },
                    itemCount: worldContext.sceneList.length),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
