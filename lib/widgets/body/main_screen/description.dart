import 'package:flutter/material.dart';

import 'package:pokedex/types/classes/stats.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

class Description extends StatelessWidget {
  const Description(this.species, {super.key});
  final Species species;

  @override
  Widget build(context) {
    final Stats base = context.dex.form.baseStats;
    final List<int> stats = base.toList();

    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.blue,
      child: Column(children: [
        Expanded(child: Text(base.toString())),
        Expanded(child: Text(stats.toString())),
      ]),
    );
  }
}
