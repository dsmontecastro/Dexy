import 'package:flutter/material.dart';

import 'package:pokedex/extensions/string.dart';

enum Generation { error, kanto, johto, hoenn, sinnoh, unova, kalos, alola, galar, paldea }

extension Shortcuts on Generation {
  //

  String get text => name.capitalize();

  Color get color => _generationColor[this] ?? Colors.transparent;

  // Constants -----------------------------------------------------------------

  static final Map<Generation, Color> _generationColor = {
    Generation.error: Colors.grey,
    Generation.kanto: const Color(0xffA8A77A),
    Generation.johto: const Color(0xffC22E28),
    Generation.hoenn: const Color(0xffA98FF3),
    Generation.sinnoh: const Color(0xffA33EA1),
    Generation.unova: const Color(0xffE2BF65),
    Generation.kalos: const Color(0xffB6A136),
    Generation.alola: const Color(0xffA6B91A),
    Generation.galar: const Color(0xff735797),
    Generation.paldea: const Color(0xffB7B7CE),
  };
}
