import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/models/world_context.dart';
import 'package:sanguo_heroes/sanguo/widgets/event_indicator.dart';
import 'package:sanguo_heroes/sanguo/widgets/seek_bar.dart';
import 'package:sanguo_heroes/sanguo/widgets/shimmer.dart';

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
  double progress;

  @override
  void initState() {
    super.initState();
    WorldContext().loadResource(DefaultAssetBundle.of(context), (progress) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            child: SeekBar(
              seeks: ["2007", "2008", "2009", "2010", "2011", "2012"],
            ),
          ),
        ),
      ),
    ));
  }
}
