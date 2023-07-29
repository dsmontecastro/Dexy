// import 'package:pokedex/extensions/string.dart';

class Stats {
  //----------------------------------------------------------------------------

  static int get count => 8;

  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  late int total;
  final int? accuracy;
  final int? evasion;

  Stats(
      {required this.hp,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.speed,
      this.accuracy,
      this.evasion}) {
    total = hp + attack + defense + specialAttack + specialDefense + speed;
  }

  Stats.blank()
      : hp = 0,
        attack = 0,
        defense = 0,
        specialAttack = 0,
        specialDefense = 0,
        speed = 0,
        total = 0,
        evasion = null,
        accuracy = null;

  //----------------------------------------------------------------------------

  @override
  String toString() => toList().toString();

  List<int> toList() => [hp, attack, defense, specialAttack, specialDefense, speed];

  factory Stats.fromString(String text) {
    List<String> chars = text.substring(1, text.length - 1).split(",");
    List<int> stats = chars.map((s) => int.parse(s)).toList();
    return Stats.fromList(stats);
  }

  Stats.fromList(List<int> stats)
      : hp = stats[0], //
        attack = stats[1], //
        defense = stats[2], //
        specialAttack = stats[3], //
        specialDefense = stats[4], //
        speed = stats[5], //
        total = stats.fold<int>(0, (x, y) => x + y),
        accuracy = stats.length > 6 ? stats[6] : null,
        evasion = stats.length > 7 ? stats[7] : null;
}
