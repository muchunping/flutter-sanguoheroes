import 'package:flutter/material.dart';
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
  var messageList = ["战斗准备"];
  var attackGrids = {};
  var defenseGrids = {};
  var timeSequence = 0;
  var array = {"":""};

  _BattleState(this.attackerSide, this.defenderSide);

  @override
  void initState() {
    super.initState();
    messageList.add("进攻方：诸葛亮施放了「真*虚空无极」对全部敌人造成了15点伤害，以及持续2回合的3点后续伤害");
    messageList.add("进攻方：曹操施放了「雄霸天下」所有友方持续3回合增加5点进攻");
    array[""] = "";
    beginFight();
  }

  Future beginFight() async {
    while (true) {
      if (attackerSide.mainFighter.health <= 0) {
        messageList.add("防守方胜利");
        break;
      }
      if (defenderSide.mainFighter.health <= 0) {
        messageList.add("进攻方胜利");
        break;
      }
      Fighter fighter = nextActor();
      await new Future.delayed(const Duration(milliseconds: 50));
    }
  }

  Fighter nextActor() {

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
    attackGrids["1"] = buildAssistantGrid(attackerSide.fighters[0]);
    attackGrids["2"] = buildAssistantGrid(attackerSide.fighters[1]);
    attackGrids["3"] = buildAssistantGrid(attackerSide.fighters[2]);
    defenseGrids["0"] = buildMasterGrid(defenderSide.mainFighter);
    defenseGrids["1"] = buildAssistantGrid(defenderSide.fighters[0]);
    defenseGrids["2"] = buildAssistantGrid(defenderSide.fighters[1]);
    defenseGrids["3"] = buildAssistantGrid(defenderSide.fighters[2]);
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
            child: ListView.builder(
              itemBuilder: (c, i) {
                return Text(messageList[i]);
              },
              itemCount: messageList.length,
            ),
          ),
        )
      ],
    );
  }
}
