import 'package:fl_chart/fl_chart.dart';

const double maxStat = 255;
const List<String> radarTitles = ["HP", "ATK", "DEF", "SPD", "SpD", "SpA"];
const List<String> statNames = ["HP", "ATK", "DEF", "SpA", "SpD", "Speed"];

enum StatMode { api, radar }

class Stats {
  //----------------------------------------------------------------------------

  static int get count => 8;

  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final int specialDefense;
  final int specialAttack;
  late int total;
  final int? accuracy;
  final int? evasion;

  Stats(
      {required this.hp,
      required this.attack,
      required this.defense,
      required this.speed,
      required this.specialDefense,
      required this.specialAttack,
      this.accuracy,
      this.evasion}) {
    total = hp + attack + defense + speed + specialDefense + specialAttack;
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

  // DB & Initialization -------------------------------------------------------

  factory Stats.fromString(String text) {
    List<String> chars = text.substring(1, text.length - 1).split(",");
    List<int> stats = chars.map((s) => int.parse(s)).toList();
    return Stats.fromList(stats);
  }

  Stats.fromList(List<int> stats) // Order matches PokeAPI
      : hp = stats[0],
        attack = stats[1],
        defense = stats[2],
        specialAttack = stats[3],
        specialDefense = stats[4],
        speed = stats[5],
        total = stats.fold<int>(0, (x, y) => x + y),
        accuracy = stats.length > 6 ? stats[6] : null,
        evasion = stats.length > 7 ? stats[7] : null;

  //----------------------------------------------------------------------------

  // Order matches RadarChart in FormStats
  List<int> toList({StatMode mode = StatMode.api}) {
    if (mode == StatMode.api) {
      return [hp, attack, defense, specialAttack, specialDefense, speed];
    } else {
      return [hp, attack, defense, speed, specialDefense, specialAttack];
    }
  }

  String getString({StatMode mode = StatMode.api}) {
    return toList(mode: mode).toString();
  }

  List<double> getDoubles({StatMode mode = StatMode.api}) {
    return toList(mode: mode).map((i) => i.toDouble()).toList();
  }

  List<RadarEntry> getEntries({StatMode mode = StatMode.api}) {
    return getDoubles(mode: mode).map((d) => RadarEntry(value: d)).toList();
  }
}
