import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sanguoheroes/sanguo/index.dart';
import 'package:sanguoheroes/sanguo/widgets/progress_bar.dart';

class MainTopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4 * scaleX,
          bottom: 4 * scaleX,
          left: 8 * scaleX,
          right: 0 * scaleX),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              PlayerWidget(),
              Padding(padding: EdgeInsets.only(top: 4 * scaleX)),
              Container(
                color: Colors.blue,
                width: 168 * scaleX,
                height: 1 * scaleX,
              )
            ],
          ),
          Container(
            width: 32 * scaleX,
            height: double.infinity,
            color: Colors.blue,
          ),
          Container(
            width: 150 * scaleX,
            height: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.blue),
                    bottom: BorderSide(color: Colors.blue))),
            padding: EdgeInsets.all(4 * scaleX),
            child: Stack(
              children: <Widget>[
                Positioned(child: _buildMenu(context, "背包")),
                Positioned(
                    child: _buildMenu(context, "任务"),
                    left: (45 + 2) * 1 * scaleX),
                Positioned(
                    child: _buildMenu(context, "技能"),
                    left: (45 + 2) * 2 * scaleX),
                Positioned(
                  child: _buildMenu(context, "宠物"),
                  top: (25 + 2) * 1 * scaleX,
                ),
                Positioned(
                    child: _buildMenu(context, "侠客"),
                    top: (25 + 2) * 1 * scaleX,
                    left: (45 * 1 + 2 * 1) * scaleX),
                Positioned(
                    child: _buildMenu(context, "成就"),
                    top: (25 + 2) * 1 * scaleX,
                    left: (45 * 2 + 2 * 2) * scaleX),
                Positioned(
                  child: _buildMenu(context, "庄园"),
                  top: (25 + 2) * 2 * scaleX,
                ),
                Positioned(
                    child: _buildMenu(context, "图鉴"),
                    top: (25 + 2) * 2 * scaleX,
                    left: (45 * 1 + 2 * 1) * scaleX),
                Positioned(
                    child: _buildMenu(context, "系统"),
                    top: (25 + 2) * 2 * scaleX,
                    left: (45 * 2 + 2 * 2) * scaleX),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, String menuName) {
    return Container(
      width: 45 * scaleX,
      height: 25 * scaleX,
      child: RaisedButton(
          color: Colors.green,
          splashColor: Colors.green.shade800,
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.of(context).pushNamed("menu", arguments: menuName);
          },
          child: Text(menuName)),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = TextStyle(fontSize: 12, color: Colors.white);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                width: 64 * scaleX,
                height: 64 * scaleX,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0 * scaleX,
              bottom: 0 * scaleX,
              child: Container(
                padding: EdgeInsets.all(1 * scaleX),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(8 * scaleX)),
                child: Text("99", style: _style),
              ),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 4 * scaleX)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("牟少侠", style: TextStyle(fontSize: 16, color: Colors.white)),
            Stack(
              children: <Widget>[
                ProgressBar(
                  value: 189990 / 299999,
                  width: 96 * scaleX,
                  height: 12 * scaleX,
                ),
                Container(
                  width: 96 * scaleX,
                  height: 12 * scaleX,
                  alignment: Alignment.center,
                  child: Text("189990/299999", style: _style),
                )
              ],
            ),
            Text("银两  9999", style: _style),
            Text("声望  后起之秀", style: _style),
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 4 * scaleX)),
      ],
    );
  }
}
