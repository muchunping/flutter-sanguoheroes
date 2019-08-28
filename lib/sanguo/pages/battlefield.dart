import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/models/fighter.dart';
import 'package:sanguo_heroes/sanguo/models/fighter_group.dart';
import 'package:sanguo_heroes/sanguo/models/player.dart';

main() => runApp(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Battlefield(
            attacker: FighterGroup(mainFighter: attacker()),
            defender: FighterGroup(mainFighter: defender()),
          ),
        ),
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

class Battlefield extends StatefulWidget {
  final FighterGroup attacker;
  final FighterGroup defender;

  Battlefield({Key key, this.attacker, this.defender}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BattleState(attacker, defender);
  }
}

class _BattleState extends State<Battlefield> {
  final FighterGroup attackerSide;
  final FighterGroup defenderSide;
  var messageList = _MessageList();
  var providers = Providers();
  var attackGrids = {};
  var defenseGrids = {};
  var timeSequence = 0.0;
  Map<Fighter, double> array = {};

  _BattleState(this.attackerSide, this.defenderSide);

  @override
  void initState() {
    super.initState();
    attackerSide.setFightSide(FightSide.attacker);
    defenderSide.setFightSide(FightSide.defender);
    providers..provide(Provider<_MessageList>.value(messageList));
    array[attackerSide.mainFighter] = attackerSide.mainFighter.duration;
    array[defenderSide.mainFighter] = defenderSide.mainFighter.duration;
    attackerSide.fighters.forEach((k, v) {
      array[v] = v.duration;
    });
    defenderSide.fighters.forEach((k, v) {
      array[v] = v.duration;
    });
    print(array);
    beginFight();
  }

  Future beginFight() async {
    while (true) {
      timeSequence = (array.values.toList()..sort())[0];
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
        await fighterAction(fighter);
        array[fighter] += fighter.duration;
        if (attackerSide.mainFighter.health <= 0) {
          messageList.add("防守方胜利");
          return;
        }
        if (defenderSide.mainFighter.health <= 0) {
          messageList.add("进攻方胜利");
          return;
        }
      }
    }
  }

  Future fighterAction(Fighter fighter) async {
    if (fighter.fightSide == FightSide.attacker) {
      var location = attackerSide.getLocation(fighter);
      messageList.add("${timeSequence.toStringAsFixed(2)} 进攻方的$location开始行动");
    } else {
      var location = defenderSide.getLocation(fighter);
      messageList.add("${timeSequence.toStringAsFixed(2)} 防守方的$location开始行动");
    }
    await new Future.delayed(const Duration(milliseconds: 1000));
    messageList.add(" 行动结束");
  }

  Widget buildMasterGrid(Fighter fighter) {
    return Container(
      width: 80 * scaleX,
      height: 80 * scaleX,
      child: buildActor(),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    );
  }

  Widget buildAssistantGrid(Fighter fighter) {
    return Container(
      width: 48 * scaleX,
      height: 48 * scaleX,
      child: buildActor(),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    );
  }

  Widget buildActor() {
    return Stack(
      children: <Widget>[
        Image.asset("images/guanyu.jpg", fit: BoxFit.fitHeight),
        SizedBox(
          height: 2 * scaleX,
          child: LinearProgressIndicator(value: 0.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    attackGrids["0"] = buildMasterGrid(attackerSide.mainFighter);
    attackGrids["1"] = buildAssistantGrid(attackerSide.fighters["a"]);
    attackGrids["2"] = buildAssistantGrid(attackerSide.fighters["b"]);
    attackGrids["3"] = buildAssistantGrid(attackerSide.fighters["c"]);
    defenseGrids["0"] = buildMasterGrid(defenderSide.mainFighter);
    defenseGrids["1"] = buildAssistantGrid(defenderSide.fighters["a"]);
    defenseGrids["2"] = buildAssistantGrid(defenderSide.fighters["b"]);
    defenseGrids["3"] = buildAssistantGrid(defenderSide.fighters["c"]);
    return Column(
      children: <Widget>[
        Container(
          width: 360 * scaleX,
          height: 240 * scaleX,
          color: Colors.yellow.shade200,
          child: Row(
            children: <Widget>[
              Spacer(),
              Column(
                children: <Widget>[
                  Text("进攻方",
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                  Container(
                    width: 160 * scaleX,
                    height: 160 * scaleX,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100 * scaleX,
                          height: 100 * scaleX,
                          alignment: Alignment.center,
                          child: attackGrids["0"],
                        ),
                        Column(
                          children: <Widget>[
                            Spacer(),
                            attackGrids["2"],
                            Spacer(),
                            attackGrids["1"],
                            Spacer(),
                            attackGrids["3"],
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Spacer(flex: 2),
              Column(
                children: <Widget>[
                  Text("防守方",
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                  Container(
                    width: 160 * scaleX,
                    height: 160 * scaleX,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Spacer(),
                            defenseGrids["2"],
                            Spacer(),
                            defenseGrids["1"],
                            Spacer(),
                            defenseGrids["3"],
                            Spacer(),
                          ],
                        ),
                        Container(
                          width: 100 * scaleX,
                          height: 100 * scaleX,
                          alignment: Alignment.center,
                          child: defenseGrids["0"],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Spacer()
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8 * scaleX),
            child: ProviderNode(
                child: Provide<_MessageList>(builder: (c, w, m) {
                  return ListView.builder(
                    itemBuilder: (c, i) {
                      return Text(m.messageList[i]);
                    },
                    itemCount: m.messageList.length,
                    physics: BouncingScrollPhysics(),
                  );
                }),
                providers: providers),
          ),
        )
      ],
    );
  }
}

class _MessageList with ChangeNotifier {
  List<String> messageList = [];

  void add(String message) {
    messageList.insert(0, message);
    notifyListeners();
  }
}
