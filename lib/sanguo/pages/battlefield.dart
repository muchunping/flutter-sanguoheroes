import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/models/fighter.dart';
import 'package:sanguo_heroes/sanguo/models/fighter_group.dart';
import 'package:sanguo_heroes/sanguo/models/player.dart';

main() => runApp(MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Battlefield(
          attackerSide: FighterGroup(mainFighter: attacker(), fighters: {
            "a": attacker()..speed = 105,
            "b": attacker()..speed = 110
          }),
          defenderSide: FighterGroup(
              mainFighter: defender(),
              fighters: {"a": attacker()..speed = 104}),
        )),
      ),
    ));

Player attacker() {
  Player attacker = Player();
  attacker.attack = 36;
  attacker.defense = 10;
  attacker.speed = 100;
  attacker.health = 100;
  return attacker;
}

Player defender() {
  Player defender = Player();
  defender.attack = 40;
  defender.defense = 10;
  defender.speed = 120;
  defender.health = 100;
  return defender;
}

class Battlefield extends StatelessWidget {
  final FighterGroup attackerSide;
  final FighterGroup defenderSide;

  Battlefield({Key key, this.attackerSide, this.defenderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => _MessageList()),
        ChangeNotifierProvider(builder: (_) => _TimeSequence()),
      ],
      child: _Impl(attackerSide: attackerSide, defenderSide: defenderSide),
    );
  }
}

class _Impl extends StatefulWidget{
  final FighterGroup attackerSide;
  final FighterGroup defenderSide;

  _Impl({Key key, this.attackerSide, this.defenderSide}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(attackerSide, defenderSide);
  }
}

class _State extends State<_Impl> {
  final FighterGroup attackerSide;
  final FighterGroup defenderSide;
  final Map<Fighter, double> array = {};

  _State(this.attackerSide, this.defenderSide) {
    attackerSide.setFightSide(FightSide.attacker);
    defenderSide.setFightSide(FightSide.defender);
    array[attackerSide.mainFighter] = attackerSide.mainFighter.duration;
    array[defenderSide.mainFighter] = defenderSide.mainFighter.duration;
    attackerSide.fighters.forEach((k, v) {
      array[v] = v.duration;
    });
    defenderSide.fighters.forEach((k, v) {
      array[v] = v.duration;
    });
  }

  @override
  void initState() {
    super.initState();
    beginFight(context);
  }

  void addMessage(BuildContext context, String message) {
    Provider.of<_MessageList>(context, listen: false).add(message);
  }

  void updateTimeSequence(BuildContext context, double timeSequence) {
    Provider.of<_TimeSequence>(context, listen: false).change(timeSequence);
  }

  Future beginFight(BuildContext context) async {
    var timeSequence = 0.0;
    await new Future.delayed(const Duration(milliseconds: 1000));
    while (true) {
      timeSequence = (array.values.toList()..sort())[0];
      updateTimeSequence(context, timeSequence);
      var fighters =
          array.entries.where((e) => e.value == timeSequence).map<Fighter>((e) {
        return e.key;
      });
      var attackerFighters =
          fighters.where((e) => e.fightSide == FightSide.attacker).toList();
      var defenderFighters =
          fighters.where((e) => e.fightSide == FightSide.defender).toList();
      bool attacker = true;
      while (attackerFighters.isNotEmpty || defenderFighters.isNotEmpty) {
        Fighter fighter;
        if (attacker) {
          if (attackerFighters.isNotEmpty) {
            fighter = attackerFighters.removeAt(0);
          } else {
            fighter = defenderFighters.removeAt(0);
          }
        } else {
          if (defenderFighters.isNotEmpty) {
            fighter = defenderFighters.removeAt(0);
          } else {
            fighter = attackerFighters.removeAt(0);
          }
        }
        attacker = !attacker;
        await fighterAction(context, timeSequence, fighter);
        array[fighter] += fighter.duration;
        if (attackerSide.mainFighter.health <= 0) {
          addMessage(context, "防守方胜利");
          return;
        }
        if (defenderSide.mainFighter.health <= 0) {
          addMessage(context, "进攻方胜利");
          return;
        }
      }
    }
  }

  Future fighterAction(
      BuildContext context, double timeSequence, Fighter fighter) async {
    if (fighter.fightSide == FightSide.attacker) {
      var location = attackerSide.getLocation(fighter);
      addMessage(
          context, "${timeSequence.toStringAsFixed(2)} 进攻方的$location开始行动");
    } else {
      var location = defenderSide.getLocation(fighter);
      addMessage(
          context, "${timeSequence.toStringAsFixed(2)} 防守方的$location开始行动");
    }
    await new Future.delayed(const Duration(milliseconds: 1000));
    addMessage(context, " 行动结束");
    await new Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {

    Widget buildActor(Fighter fighter) {
      if (fighter == null) {
        return null;
      }
      return Stack(
        children: <Widget>[
          Image.asset("images/guanyu.jpg", fit: BoxFit.fitHeight),
          Consumer<_TimeSequence>(builder: (context, time, _) {
            var v = (time.timeSequence % fighter.duration) / fighter.duration;
            return SizedBox(
                height: 2 * scaleX,
                child: LinearProgressIndicator(
                  value: v,
                ));
          }),
          Padding(
            padding: EdgeInsets.only(top: 2 * scaleX),
            child: SizedBox(
              height: 2 * scaleX,
              child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
            ),
          )
        ],
      );
    }

    Widget buildFighter(bool isMaster, Fighter fighter) {
      var size = isMaster ? 80 : 48;
      return Container(
        width: size * scaleX,
        height: size * scaleX,
        child: buildActor(fighter),
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      );
    }

    Widget buildFightGroup(bool left, FighterGroup group) {
      var side = left ? "进攻方" : "防守方";
      var alignment = left ? MainAxisAlignment.start : MainAxisAlignment.end;
      var front = Column(
        children: <Widget>[
          Spacer(),
          buildFighter(false, group.fighters["b"]),
          Spacer(),
          buildFighter(false, group.fighters["a"]),
          Spacer(),
          buildFighter(false, group.fighters["c"]),
          Spacer(),
        ],
      );
      var back = Container(
        width: 100 * scaleX,
        height: 100 * scaleX,
        alignment: Alignment.center,
        child: buildFighter(false, group.mainFighter),
      );
      return Column(
        children: <Widget>[
          Text(side, style: TextStyle(color: Colors.black, fontSize: 24)),
          Container(
            width: 160 * scaleX,
            height: 160 * scaleX,
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: Row(
                mainAxisAlignment: alignment,
                children: left ? [back, front] : [front, back]),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[

        Container(
          width: 360 * scaleX,
          height: 240 * scaleX,
          color: Colors.yellow.shade200,
          child: Row(children: <Widget>[
            Spacer(),
            buildFightGroup(true, attackerSide),
            Spacer(flex: 2),
            buildFightGroup(false, defenderSide),
            Spacer()
          ]),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8 * scaleX),
            child: Consumer<_MessageList>(builder: (c, w, m) {
              return ListView.builder(
                itemBuilder: (c, i) {
                  return Text(w.messageList[i]);
                },
                itemCount: w.messageList.length,
                physics: BouncingScrollPhysics(),
              );
            }),
          ),
        )
      ],
    );
  }
}

class _TimeSequence with ChangeNotifier {
  double timeSequence = 0.0;

  void change(double newTimeSequence) {
    timeSequence = newTimeSequence;
    notifyListeners();
  }
}

class _MessageList with ChangeNotifier {
  List<String> messageList = [];

  void add(String message) {
    messageList.insert(0, message);
    notifyListeners();
  }
}
