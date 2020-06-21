import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:sanguoheroes/sanguo/index.dart';
import 'package:sanguoheroes/sanguo/models/npc.dart';

class SceneShower extends StatelessWidget {
  final List<Npc> npcList;

  final TextStyle shopStyle =
      TextStyle(color: Colors.blueAccent, fontSize: 14 * scaleX);
  final List<Rect> rectAll = [];
  final Math.Random random = Math.Random(DateTime.now().millisecond);
  int index = -1;

  SceneShower({Key key, this.npcList}) : super(key: key);

  Rect generateRect(Size size, Npc npc) {
    var dx, dy;
    if (npc.id.length < 3) {
      index++;
      var radius = 32 * scaleX * 2;
      if (index % 2 == 0) {
        //left
        var rect = Rect.fromLTWH(
            10 * scaleX,
            10 * scaleX + (10 * scaleX + radius) * (index ~/ 2),
            radius,
            radius);
        rectAll.add(rect);
        return rect;
      } else {
        //right
        var rect = Rect.fromLTWH(
            size.width - (10 * scaleX) - radius,
            10 * scaleX + (10 * scaleX + radius) * (index ~/ 2),
            radius,
            radius);
        rectAll.add(rect);
        return rect;
      }
    } else {
      var radius = 24 * scaleX;
      var hasCover = true;
      while (hasCover) {
        hasCover = false;
        dx = random.nextInt((size.width - 20 * scaleX - radius * 2).toInt()) +
            10 * scaleX +
            radius;
        dy = random.nextInt((size.height - 20 * scaleX - radius * 2).toInt()) +
            10 * scaleX +
            radius;
        for (var rect in rectAll) {
          if (Math.sqrt(Math.pow(rect.center.dx - dx, 2) +
                  Math.pow(rect.center.dy - dy, 2)) <
              rect.width / 2 + radius) {
            hasCover = true;
            break;
          }
        }
      }
      var rect = Rect.fromCircle(
          center: Offset(dx.toDouble(), dy.toDouble()), radius: radius);
      rectAll.add(rect);
      return rect;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: npcList.map((e) {
            return _NpcShower(
                rect: generateRect(constraints.biggest, e), npc: e);
          }).toList(),
        );
      },
    );
  }
}

class _NpcShower extends StatelessWidget {
  final Rect rect;
  final Npc npc;

  _NpcShower({Key key, this.rect, this.npc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shopStyle = TextStyle(color: Colors.blueAccent, fontSize: 14 * scaleX);
    return Positioned(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                    title: Text("选择"),
                    children:
                        npc.actions.map<SimpleDialogOption>((String action) {
                      return SimpleDialogOption(
                        child: Text(action),
                        onPressed: () {
                          Navigator.pop(context);
                          handAction(context, action, npc);
                        },
                      );
                    }).toList());
              });
        },
        child: Container(
          width: rect.width,
          height: rect.height,
          decoration: npc.id.length < 3
              ? BoxDecoration(border: Border.all(color: Colors.blueAccent))
              : BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(rect.width / 2)),
          child: Center(child: Text(npc.name, style: shopStyle)),
        ),
      ),
      left: rect.left,
      top: rect.top,
    );
  }

  void handAction(BuildContext context, String action, Npc npc) {
    if (action == "观察") {
      Navigator.of(context).pushNamed("detail", arguments: npc);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: Text("选择"), children: [
            SingleChildScrollView(
              child: Container(
                width: 280 * scaleX,
                height: 160 * scaleX,
                color: Colors.yellowAccent,
                child: LayoutBuilder(builder: (c, b) {
                  print(b.biggest.width);
                  print(b.biggest.width / scaleX);
                  return Row(
                    children: <Widget>[
                      Container(
                        width: 100 * scaleX,
                        height: 200 * scaleX,
                        color: Colors.green,
                      ),
                      Container(
                        width: 190 * scaleX,
                        height: 200 * scaleX,
                        color: Colors.blueAccent,
                      )
                    ],
                  );
                }),
              ),
            )
          ]);
        });
  }
}
