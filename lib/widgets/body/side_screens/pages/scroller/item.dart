import 'package:flutter/material.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.id, this.size, {super.key});
  final int id;
  final Size size;

  @override
  Widget build(context) {
    final Dex dex = context.dex;
    final bool flag = dex.dexIndex == id;

    final Species pkmn = dex.getSpecies(id);

    return Container(
      width: size.width / 3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: flag ? Colors.black : Colors.red,
      ),
      child: Text(
        "${pkmn.id}-${pkmn.name}",
        textAlign: TextAlign.right,
        style: TextStyle(color: flag ? Colors.white : Colors.black),
      ),
    );
  }
}
