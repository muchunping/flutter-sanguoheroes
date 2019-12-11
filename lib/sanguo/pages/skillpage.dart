import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/index.dart';

main() =>
    runApp(MaterialApp(home: Scaffold(body: SafeArea(child: SkillTree()))));

class SkillTree extends StatefulWidget {
  @override
  _SkillTreeState createState() => _SkillTreeState();
}

class _SkillTreeState extends State<SkillTree>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
            labelColor: Colors.black,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            controller: _tabController),
        Expanded(
            child: TabBarView(
          children: tabs.map((e) {
            return SkillTreeView();
          }).toList(),
          controller: _tabController,
        ))
      ],
    );
  }
}

class SkillTreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200,
      padding: EdgeInsets.all(24 * scaleX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SkillGridRect(),
          SkillLineV(),
          Row(
            children: <Widget>[
              SkillGridCircle(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillGridRect(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillLineV(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineV(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillGridRect(),
              SkillLineH(),
              SkillGridRect(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillGridCircle(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillLineV(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineV(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillGridCircle(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillGridCircle(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillLineV(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineV(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillGridRect(),
              SkillLineH(),
              SkillGridCircle(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillLineH(),
              SkillGridRect(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillLineV(),
            ],
          ),
          Row(
            children: <Widget>[
              SkillLineNone(),
              SkillLineNone(),
              SkillLineNone(),
              SkillGridRect(),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillGridRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56 * scaleX,
      height: 56 * scaleX,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: RadialGradient(
              colors: [Colors.black26, Colors.black38, Colors.black54]),
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.all(Radius.circular(8))),
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

class SkillLineV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 56 * scaleX,
      height: 28 * scaleX,
      color: Colors.transparent,
      child: Container(
        height: 28 * scaleX,
        width: 1 * scaleX,
        color: Colors.black87,
      ),
    );
  }
}

class SkillLineH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 28 * scaleX,
      height: 28 * scaleX,
      color: Colors.transparent,
      child: Container(
        height: 1 * scaleX,
        width: 28 * scaleX,
        color: Colors.black87,
      ),
    );
  }
}

class SkillLineNone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 28 * scaleX,
      height: 28 * scaleX,
      color: Colors.transparent,
    );
  }
}
