import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/models/item.dart';
import 'package:sanguo_heroes/sanguo/models/scene.dart';
import 'package:sanguo_heroes/sanguo/models/world_context.dart';
import 'package:sanguo_heroes/sanguo/pages/npc_detail.dart';
import 'package:sanguo_heroes/sanguo/widgets/event_indicator.dart';
import 'package:sanguo_heroes/sanguo/widgets/location_indicator.dart';
import 'package:sanguo_heroes/sanguo/widgets/shimmer.dart';
import 'package:sanguo_heroes/sanguo/pages/home.dart' as hp;
import 'package:sanguo_heroes/test.dart';

main() => runApp(MyApp());

const Size uxSize = Size(360, 640);
final MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
final scaleX =
    (mediaQuery.size.width - mediaQuery.padding.horizontal) / uxSize.width;
WorldContext worldContext;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      routes: {
        "home": (c) => hp.HomePage(),
        "detail": (c) => NpcDetail(),
//        "detail": (c) => NewPage(),
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
                height: double.infinity,
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

  void showSceneExitDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Text("选择"),
              children: worldContext.currentScene.gates
                  .map<SimpleDialogOption>((Gate gate) {
                var scene = worldContext.sceneMap[gate.id];
                return SimpleDialogOption(
                  child: Text("${scene.name}"),
                  onPressed: () {
                    worldContext.currentScene = scene;
                    Navigator.pop(context);
                    setState(() {});
                  },
                );
              }).toList());
        });
  }

  void showDetailPage(Item item) {
    Navigator.pushNamed(context, "", arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 360 * scaleX,
                  height: 92 * scaleX,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors.cyan,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 62 * scaleX,
                                  height: 62 * scaleX,
                                  color: Colors.blue,
                                  margin: EdgeInsets.all(1 * scaleX),
                                  child: Image.asset("images/ic_launcher.png"),
                                ),
                                Container(
                                  width: 200 * scaleX,
                                  height: 64 * scaleX,
                                  color: Colors.cyan,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4 * scaleX, right: 4 * scaleX),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${worldContext.player.name}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${worldContext.player.name}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "${worldContext.player.name}",
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: <Widget>[
                                Icon(Icons.ac_unit, size: 20 * scaleX),
                                Icon(Icons.adjust, size: 20 * scaleX),
                                Icon(Icons.alternate_email, size: 20 * scaleX),
                                Icon(Icons.album, size: 20 * scaleX),
                                Icon(Icons.audiotrack, size: 20 * scaleX),
                                Icon(Icons.blur_circular, size: 20 * scaleX)
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Text("${worldContext.currentScene.name}"),
                            ),
                            width: 94 * scaleX,
                            height: 24 * scaleX,
                            padding: EdgeInsets.all(4 * scaleX),
                            color: Colors.cyanAccent,
                          ),
                          LocationIndicator(0, 20 * scaleX, 30 * scaleX,
                              94 * scaleX, 42 * scaleX),
                          Container(
                            width: 94 * scaleX,
                            height: 24 * scaleX,
                            color: Colors.cyanAccent,
                            child: FlatButton(
                              onPressed: showSceneExitDialog,
                              child: Text("离开"),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                ),
                Expanded(
                  child: Container(
                    width: 360 * scaleX,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var item = worldContext
                            .npcMap[worldContext.currentScene.npcIds[index]];
                        return ListTile(
                          leading: Icon(Icons.account_balance, size: 36),
                          title: Text(item.name),
                          subtitle: Text(item.actions.toString()),
                          trailing: Icon(Icons.child_care),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return index % 2 == 0 ? divider1 : divider2;
                      },
                      itemCount: worldContext.currentScene.npcIds.length,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.blueGrey.shade200),
                        right: BorderSide(color: Colors.blueGrey),
                        left: BorderSide(color: Colors.blueGrey),
                        bottom: BorderSide(color: Colors.blueGrey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
