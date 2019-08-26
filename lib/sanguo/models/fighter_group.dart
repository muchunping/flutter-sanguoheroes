import 'package:flutter/material.dart';
import 'package:sanguo_heroes/sanguo/models/fighter.dart';

class FighterGroup{
  final Map<int, Fighter> fighters;
  final Fighter mainFighter;

  FighterGroup({this.fighters = const {}, @required this.mainFighter});
}
