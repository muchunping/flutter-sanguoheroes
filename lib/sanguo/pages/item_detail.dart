import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/index.dart';

main() => runApp(MaterialApp(home: Detail()));

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var smallStyle = TextStyle(color: Colors.white, fontSize: 12 * scaleX);
    var padding =
        EdgeInsets.symmetric(vertical: 1 * scaleX, horizontal: 2 * scaleX);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: 360 * scaleX,
              height: 144 * scaleX,
              padding: EdgeInsets.all(8 * scaleX),
              color: Color.fromARGB(255, 50, 169, 241),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "images/guanyu.jpg",
                          width: 72 * scaleX,
                          height: 72 * scaleX,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16 * scaleX, right: 16 * scaleX),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                width: 36 * scaleX,
                                height: 24 * scaleX,
                                child: Center(
                                    child: Text("白色", style: smallStyle)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.white),
                                    right: BorderSide(color: Colors.white),
                                    top: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 36 * scaleX,
                                height: 24 * scaleX,
                                child: Center(
                                    child: Text("蓝色", style: smallStyle)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.white),
                                    top: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 36 * scaleX,
                                height: 24 * scaleX,
                                child: Center(
                                    child: Text("金色", style: smallStyle)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.white),
                                    top: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 36 * scaleX,
                                height: 24 * scaleX,
                                child: Center(
                                    child: Text("橙色", style: smallStyle)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.white),
                                    top: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 36 * scaleX,
                                height: 24 * scaleX,
                                child: Center(
                                    child: Text("红色", style: smallStyle)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.white),
                                    top: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                              )
                            ]),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 90 * scaleX,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: Colors.white),
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            Text("武力", style: smallStyle),
                                            Text("  50", style: smallStyle),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center),
                                      Row(
                                          children: <Widget>[
                                            Text("智力", style: smallStyle),
                                            Text("  50", style: smallStyle),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 90 * scaleX,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(color: Colors.white),
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            Text("行动", style: smallStyle),
                                            Text("  50", style: smallStyle),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center),
                                      Row(
                                          children: <Widget>[
                                            Text("抗性", style: smallStyle),
                                            Text("  50", style: smallStyle),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8 * scaleX),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "关羽",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16 * scaleX),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8 * scaleX, bottom: 1.5 * scaleX),
                          child: Text(
                            "字 云长",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12 * scaleX),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("河东郡解县(今山西运城)人，人称“美髯公”。",
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.cyanAccent,
              padding: EdgeInsets.symmetric(
                  vertical: 8 * scaleX, horizontal: 16 * scaleX),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("专属："),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("过关斩将"),
                      Text("对单个敌军造成严重伤害，击杀目标后再次施放\n威力 255"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.yellowAccent,
              padding: EdgeInsets.symmetric(
                  vertical: 8 * scaleX, horizontal: 16 * scaleX),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("特技："),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("武圣 (30级)"),
                      Text("武力 +17\n物攻 + 1200\n施放[过关斩将]时概率三倍伤害"),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 8 * scaleX, horizontal: 16 * scaleX),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Text(
                      "简介：\n        本字长生，后改字云长，河东郡解县（今山西运城）人，被称为“美髯公”。早年跟随刘备颠沛流离，辗转各地，和刘备、张飞情同兄弟，因而虽然受到了曹操的厚待，但关羽仍然借机离开曹操，去追随刘备。赤壁之战后，关羽助刘备、周瑜攻打曹仁所驻守的南郡，而后刘备势力逐渐壮大，关羽则长期镇守荆州。\n        建安二十四年，关羽在与曹仁之间的军事摩擦中逐渐占据上风，随后水陆并进，围攻襄阳、樊城，并利用秋季大雨，水淹七军，将前来救援的于禁打的全军覆没。关羽威震华夏，使得曹操一度产生迁都以避关羽锋锐的想法。\n        但随后东吴孙权派遣吕蒙、陆逊袭击了关羽的后方，关羽又在与徐晃的交战中失利，最终进退失据，兵败被杀"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
