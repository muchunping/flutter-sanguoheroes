import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/widgets/scene_actor.dart';

main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: 360 * scaleX,
              height: 100 * scaleX,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.brown)),
            ),
            Container(
              width: 360 * scaleX,
              height: 42 * scaleX,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
            ),
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.orange)),
                child: SingleChildScrollView(
                  child: Container(
                    height: 720 * scaleX,
                    child: SceneShower(
                      npcList: worldContext.currentScene.npcIds.map((id) {
                        return worldContext.npcMap[id];
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
