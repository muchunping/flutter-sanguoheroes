import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/models/fighter.dart';

class FighterGroup {
  final Map<String, Fighter> fighters;
  final Fighter mainFighter;

  FighterGroup({this.fighters = const {}, @required this.mainFighter});

  void setFightSide(FightSide side) {
    mainFighter.fightSide = side;
    fighters.forEach((_, fighter) => fighter.fightSide = side);
  }

  String getLocation(Fighter fighter){
    if(fighter == mainFighter){
      return "主将";
    }else{
      return fighters.entries.firstWhere((e) => e.value == fighter, orElse: (){return null;})?.key ?? "-";
    }
  }
}
