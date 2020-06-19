class Fighter {
  //生命值
  int health;

  //攻击值
  int attack;

  //防御值
  int defense;

  //速度值
  int speed;

  //属于进攻方活着防守方
  FightSide fightSide;

  double get duration => 10000 / speed;
}

enum FightSide { attacker, defender }
