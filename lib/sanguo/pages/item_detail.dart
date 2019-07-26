import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/index.dart';

main() => runApp(MaterialApp(home: Detail()));

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/pic1.png",
              width: double.infinity,
              height: 128 * scaleX,
            ),
            Container(
              width: double.infinity,
              color: Colors.cyanAccent,
              padding: EdgeInsets.symmetric(
                  vertical: 8 * scaleX, horizontal: 16 * scaleX),
              child: Row(
                children: <Widget>[
                  Text("四维："),
                  Spacer(),
                  Icon(Icons.audiotrack),
                  Text("  50"),
                  Spacer(),
                  Icon(Icons.audiotrack),
                  Text("  50"),
                  Spacer(),
                  Icon(Icons.audiotrack),
                  Text("  50"),
                  Spacer(),
                  Icon(Icons.audiotrack),
                  Text("  50"),
                  Spacer(),
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
                      Text("武圣 (未激活)"),
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
