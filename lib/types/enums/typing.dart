import 'package:flutter/material.dart';

const int typeCount = 18; // Excludes Special Cases

enum Typing {
  error,
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,

  // Special Cases
  uknown,
  shadow
}

extension Shortcuts on Typing {
  //

  String get text => name.toUpperCase();
  Color get color => _typingColor[this] ?? Colors.transparent;

  List<double> get strengths => _strengthChart[0];
  List<double> get weaknesses => _weaknessChart[0];

  // Constants -----------------------------------------------------------------

  static final Map<Typing, Color> _typingColor = {
    Typing.error: Colors.grey,
    Typing.normal: const Color(0xffA8A77A),
    Typing.fighting: const Color(0xffC22E28),
    Typing.flying: const Color(0xff91b0fe),
    Typing.poison: const Color(0xffA33EA1),
    Typing.ground: const Color(0xffE2BF65),
    Typing.rock: const Color(0xffB6A136),
    Typing.bug: const Color(0xffA8B820),
    Typing.ghost: const Color(0xff735797),
    Typing.steel: const Color(0xffB7B7CE),
    Typing.fire: const Color(0xffEE8130),
    Typing.water: const Color(0xff6390F0),
    Typing.grass: const Color(0xff78C850),
    // Typing.grass: const Color(0xff40b088),
    Typing.electric: const Color(0xffF8D030),
    Typing.psychic: const Color(0xffF95587),
    Typing.ice: const Color(0xff96D9D6),
    Typing.dragon: const Color(0xff6F35FC),
    Typing.dark: const Color(0xff705746),
    Typing.fairy: const Color(0xffffc3d0),
    Typing.uknown: Colors.white,
    Typing.shadow: Colors.black,
  };

  // static final Map<Typing, Color> _typingColor = {
  //   Typing.error: Colors.grey,
  //   Typing.normal: const Color(0xffA8A77A),
  //   Typing.fighting: const Color(0xffC22E28),
  //   Typing.flying: const Color(0xffA98FF3),
  //   Typing.poison: const Color(0xffA33EA1),
  //   Typing.ground: const Color(0xffE2BF65),
  //   Typing.rock: const Color(0xffB6A136),
  //   Typing.bug: const Color(0xffA6B91A),
  //   Typing.ghost: const Color(0xff735797),
  //   Typing.steel: const Color(0xffB7B7CE),
  //   Typing.fire: const Color(0xffEE8130),
  //   Typing.water: const Color(0xff6390F0),
  //   Typing.grass: const Color(0xff7AC74C),
  //   Typing.electric: const Color(0xffF7D02C),
  //   Typing.psychic: const Color(0xffF95587),
  //   Typing.ice: const Color(0xff96D9D6),
  //   Typing.dragon: const Color(0xff6F35FC),
  //   Typing.dark: const Color(0xff705746),
  //   Typing.fairy: const Color(0xffD685AD),
  //   Typing.uknown: Colors.white,
  //   Typing.shadow: Colors.black,
  // };

  static const List<List<double>> _strengthChart = [
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], // Error
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 1.0, 1.0, 0.5, 1.0], // Normal
    [0.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 0.5, 0.5, 0.5, 2.0, 0.0, 1.0, 2.0, 2.0, 0.5], // Fighting
    [0.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0], // Flying
    [0.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 0.0, 2.0], // Poison
    [0.0, 1.0, 2.0, 1.0, 2.0, 0.5, 1.0, 1.0, 2.0, 1.0, 0.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0], // Ground
    [0.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0], // Rock
    [0.0, 1.0, 0.5, 1.0, 1.0, 2.0, 1.0, 0.5, 0.5, 1.0, 0.5, 2.0, 1.0, 1.0, 0.5, 1.0, 2.0, 0.5, 0.5], // Bug
    [0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 1.0], // Ghost
    [0.0, 1.0, 0.5, 0.5, 0.5, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 2.0], // Steel
    [0.0, 1.0, 0.5, 0.5, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 0.5, 1.0, 2.0, 1.0], // Fire
    [0.0, 1.0, 2.0, 0.5, 1.0, 0.5, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0], // Water
    [0.0, 1.0, 0.5, 2.0, 1.0, 0.5, 1.0, 1.0, 0.5, 2.0, 0.5, 1.0, 0.5, 2.0, 1.0, 0.5, 1.0, 0.5, 1.0], // Grass
    [0.0, 1.0, 1.0, 2.0, 0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 2.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0], // Electric
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0], // Psychic
    [0.0, 1.0, 0.5, 0.5, 1.0, 2.0, 0.5, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0], // Ice
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 0.0], // Dragon
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 0.5], // Dark
    [0.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 1.0] // Fairy
  ];

  static const List<List<double>> _weaknessChart = [
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], // Error
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0], // Normal
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 0.5, 1.0, 1.0, 0.5, 1.0, 2.0], // Fighting
    [0.0, 1.0, 1.0, 1.0, 2.0, 0.5, 2.0, 0.5, 1.0, 0.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0], // Flying
    [0.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 0.5, 0.5, 2.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5], // Poison
    [0.0, 1.0, 1.0, 2.0, 0.0, 2.0, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0], // Ground
    [0.0, 0.5, 0.5, 2.0, 1.0, 2.0, 1.0, 2.0, 0.5, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0], // Rock
    [0.0, 1.0, 2.0, 1.0, 1.0, 0.5, 1.0, 0.5, 1.0, 0.5, 2.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0], // Bug
    [0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0], // Ghost
    [0.0, 0.5, 2.0, 1.0, 1.0, 0.5, 0.5, 2.0, 0.0, 2.0, 0.5, 0.5, 0.5, 0.5, 1.0, 0.5, 1.0, 0.5, 0.5], // Steel
    [0.0, 1.0, 0.5, 2.0, 1.0, 0.5, 0.5, 1.0, 1.0, 2.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 0.5, 0.5], // Fire
    [0.0, 1.0, 0.5, 0.5, 2.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0], // Water
    [0.0, 1.0, 2.0, 0.5, 0.5, 0.5, 2.0, 1.0, 2.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], // Grass
    [0.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0], // Electric
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0], // Psychic
    [0.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0], // Ice
    [0.0, 1.0, 0.5, 0.5, 0.5, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0], // Dragon
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.0, 2.0, 1.0, 0.5, 1.0, 0.5, 1.0, 2.0], // Dark
    [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 0.0, 0.5, 2.0, 1.0], // Fairy
  ];
}
