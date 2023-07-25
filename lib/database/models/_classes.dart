class Stats {
  //----------------------------------------------------------------------------

  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  late int total;

  Stats(
      {required this.hp,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.speed}) {
    total = hp + attack + defense + specialAttack + specialDefense + speed;
  }

  Stats.blank()
      : hp = 0,
        attack = 0,
        defense = 0,
        specialAttack = 0,
        specialDefense = 0,
        speed = 0,
        total = 0;

  //----------------------------------------------------------------------------

  @override
  String toString() {
    return toList().toString();
  }

  List<int> toList() {
    return [hp, attack, defense, specialAttack, specialDefense, speed];
  }

  Stats.fromList(List<int> stats)
      : hp = stats[0],
        attack = stats[1],
        defense = stats[2],
        specialAttack = stats[3],
        specialDefense = stats[4],
        speed = stats[5],
        total = stats.fold(0, (x, y) => x + y);
}
