import 'package:flutter/material.dart';
import "package:xml/xml.dart" as xml;

void main() {
  runApp(SanguoApp());
  PaintingBinding.instance.imageCache.maximumSize = 100;
}

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
  final style = TextStyle(color: Colors.black, fontSize: 12.0);
  final Widget divider1 = Divider(color: Colors.blue);
  final Widget divider2 = Divider(color: Colors.green);
  final WorldContext worldContext = WorldContext();

  Widget _buildStatusBars(BuildContext context) {

    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 25,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 4),
          child: Text("江湖小虾米"),
        )),

//        Expanded(
//          child: Row(
//            children: <Widget>[
//              Padding(padding: EdgeInsets.only(left: 4)),
//              Text("江湖小虾米"),
//              Spacer(),
//              Container(
//                width: 45,
//                height: 25,
//                child: RaisedButton(
//                    color: Colors.green,
//                    splashColor: Colors.green.shade800,
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {
//                      DefaultAssetBundle.of(context)
//                          .loadString("xmls/npcs.xml")
//                          .then((loadString) {
//                        var parse = xml.parse(loadString);
//                        for (var v in parse.children) {
//                          if (v is xml.XmlElement &&
//                              v.name.local == "npc-list") {
//                            for (var t in v.children) {
//                              print("${t.text},$t");
//                            }
//                          }
//                        }
////                        parse.attributes.forEach((v){
////                          print("${v.name},${v.text}");
////                        });
//                      });
////                      DefaultAssetBundle.of(context).loadStructuredData("xmls/npcs.xml", (v){
////                        var parse = xml.parse(v);
////                        parse.attributes.forEach((v){
////                          print("${v.name},${v.text}");
////                        });
////                      });
//                    },
//                    child: Text("详情")),
//              ),
//            ],
//          ),
//        ),
        Container(
          height: 1,
          color: Colors.red,
        ),
        Row(
          children: <Widget>[
            Spacer(),
            _buildMenu("属性"),
            Spacer(),
            _buildMenu("技能"),
            Spacer(),
            _buildMenu("任务"),
            Spacer(),
          ],
        )
//        Stack(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 18,
//              decoration: BoxDecoration(
//                border: Border.all(color: Colors.green),
//              ),
//              child: CustomPaint(
//                painter: _LinearProgressIndicatorPainter(value: 0.9),
//              ),
//            ),
//            Container(
//              height: 18,
//              padding: EdgeInsets.only(left: 2),
//              child: Text(
//                "HP:9000/9999",
//                style: style,
//              ),
//              alignment: Alignment.centerLeft,
//            )
//          ],
//        ),
//        Container(
//          height: 1,
//          color: Colors.red,
//        ),
//        Stack(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 18,
//              decoration: BoxDecoration(
//                border: Border.all(color: Colors.green),
//              ),
//              child: CustomPaint(
//                painter: _LinearProgressIndicatorPainter(value: 0.2),
//              ),
//            ),
//            Container(
//              height: 18,
//              padding: EdgeInsets.only(left: 2),
//              child: Text(
//                "MP:2000/9999",
//                style: style,
//              ),
//              alignment: Alignment.centerLeft,
//            )
//          ],
//        )
      ],
    );
  }

  Widget _buildMenuArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            _buildMenu("宠物"),
            Spacer(),
            _buildMenu("门派"),
            Spacer(),
            _buildMenu("技能"),
            Spacer(),
            _buildMenu("成就"),
            Spacer(),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            _buildMenu("任务"),
            Spacer(),
            _buildMenu("图鉴"),
            Spacer(),
            _buildMenu("攻略"),
            Spacer(),
            _buildMenu("神器"),
            Spacer(),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            _buildMenu("备用一"),
            Spacer(),
            _buildMenu("备用二"),
            Spacer(),
            _buildEmptyMenu(),
            Spacer(),
            _buildEmptyMenu(),
            Spacer(),
          ],
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildMenu(String menuName) {
    return Container(
      width: 45,
      height: 25,
      child: RaisedButton(
          color: Colors.green,
          splashColor: Colors.green.shade800,
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Text(menuName)),
    );
  }

  Widget _buildEmptyMenu() {
    return Container(
      width: 45,
      height: 25,
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      height: 40,
      child: Text(
        "秦始皇陵一层",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildContentView() {
    return Expanded(
      child: Container(
        color: Colors.yellow.shade200,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Text("$index");
            },
            separatorBuilder: (BuildContext context, int index) {
              return index % 2 == 0 ? divider1 : divider2;
            },
            itemCount: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Actor>(() {
      return worldContext.loadResources(context);
    }).then((v) {}).catchError((e) {});
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
                            child: _buildStatusBars(context),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                            ),
                            child: CustomPaint(
                              painter:
                                  _LinearProgressIndicatorPainter(value: 0.5),
                            ),
                          ),
                          Container(
                            height: 18,
                            padding: EdgeInsets.only(left: 2),
                            child: Text(
                              "EXP:10000000/20000000",
                              style: style,
                            ),
                            alignment: Alignment.centerLeft,
                          )
                        ],
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
                child: _buildMenuArea(),
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
            child: Column(
              children: <Widget>[
                _buildTitle(),
                Container(
                  height: 1,
                  color: Colors.red,
                ),
                _buildContentView(),
              ],
            ),
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

class WorldContext {
  Scene currentScene;

  List<Scene> sceneList;

  loadResources(BuildContext context) async {
    DefaultAssetBundle.of(context)
        .loadString("xmls/npcs.xml")
        .then((loadString) {
      var parse = xml.parse(loadString);
      for (var v in parse.children) {
        if (v is xml.XmlElement && v.name.local == "npc-list") {
          var npcList = List();
          for (var t in v.children) {
            if (t is xml.XmlElement) {
              print("$t");
              if (t.name.local == "npc") {
                var npc = Map();
                for (var n in t.attributes) {
                  npc.putIfAbsent(n.name, () {
                    return n.value;
                  });
                }
                npcList.add(npc);
              }
            }
          }
          print(npcList);
        }
      }
    });
  }
}

abstract class Scene {
  int id;
  String name;
  int type;
  List<int> npcIDs;

  Scene(this.id, this.name, this.type, this.npcIDs);
}

class IsolatedRoom extends Scene {
  IsolatedRoom(int id, String name, List<int> npcIDs)
      : super(id, name, 1, npcIDs);
}

class City extends Scene {
  List<int> gateIDs;

  City(int id, String name, List<int> npcIDs, this.gateIDs)
      : super(id, name, 0, npcIDs);
}

class Actor {
  String name;
  String level;
  Range hp;
  Range mp;
  Range exp;
}

class Range {
  int max;
  int current;
}

WorldContext appReducer(WorldContext state, action) {
  return WorldContext();
}
