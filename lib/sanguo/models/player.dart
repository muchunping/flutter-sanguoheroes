import 'package:sanguo_heroes/sanguo/index.dart';
import 'package:sanguo_heroes/sanguo/models/fighter.dart';

class Player extends Fighter{
  String name = "";
  bool sex;
  int level;
  int experience;
//  Profession profession;
  FightProperty fightProperty;
  String sceneId;
  List<Skill> skillList;
  List<Item> itemList;
  List<Buff> buffList;
  List<Task> taskList;
  Wear wear;

  Player() {
    name = "来自星星的妮";
    sex = true;
//    profession = Profession.warrior;
    level = 1;
    experience = 0;
    fightProperty = FightProperty();
  }

  Player.load();
}

//enum Profession {
//  warrior, //前排肉盾，吸收仇恨
//  wizard, //远程魔法输出，范围伤害
//  archer, //远程物理输出，单体伤害
//  Warlock //辅助治疗，召唤宠物
//}

class FightProperty {
  int pa = 10, ma = 10, pd = 1, md = 1, hp = 100, mp = 100, hr = 100, dr = 0, spd = 100;
}

class Skill{
  String id;
  bool active;
}

class Item{
  String id;
  int amount;
}

class Buff{
  String id;
  String leftTime;
}

class Task{
  String id;
  bool completed;
}

class Wear{
  Equipment head;
  Equipment body;
  Equipment leftHand;
  Equipment rightHand;
  Equipment leg;
  Equipment foot;
  Equipment finger;
  Equipment neck;
  Equipment wrist;

  get pa => worldContext.equipmentMap[head.id].pa;
}

//enum WearSlot{
//  head, body, hand_left, hand_right, leg, foot, finger, neck, wrist
//}

class Equipment{
  String id;
}
