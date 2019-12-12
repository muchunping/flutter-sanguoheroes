import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/widgets/progress_bar.dart';

main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: SkillTree(),
          appBar: AppBar(
            title: Text("技能树"),
          ),
        ),
      ),
    );

class SkillTree extends StatefulWidget {
  @override
  _SkillTreeState createState() => _SkillTreeState();
}

class _SkillTreeState extends State<SkillTree> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 22 * scaleX,
                  height: 250 * scaleX,
                  child: ProgressBar(
                    value: progress / 32,
                    width: 20 * scaleX,
                    height: 248 * scaleX,
                    direction: Direction.btt,
                  ),
                ),
                Ink(
                  color: Colors.purple,
                  width: 28 * scaleX,
                  height: 28 * scaleX,
                  child: InkWell(
                    onTap: () {
                      progress++;
                      setState(() {});
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
            SkillGridCircle(),
          ],
        ),
      ),
    );
  }
}

class SkillGridCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 56 * scaleX,
        height: 56 * scaleX,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [Colors.black26, Colors.black38, Colors.black54]),
          border: Border.all(color: Colors.black87),
        ));
  }
}
