import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/widgets/main_top.dart';
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
              decoration: BoxDecoration(color: Colors.green.shade200),
              child: MainTopWidget(),
            ),
            Container(
              width: 360 * scaleX,
              height: 42 * scaleX,
              decoration:
                  BoxDecoration(color: Color.fromARGB(0xAA, 0xB5, 0xE5, 0xEE)),
              child: Center(
                child: Text(
                  worldContext.currentScene.name,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
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
