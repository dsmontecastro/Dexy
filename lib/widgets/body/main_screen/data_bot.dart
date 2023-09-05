import 'package:flutter/material.dart';

import 'package:pokedex/database/models/species.dart';

class DataBot extends StatelessWidget {
  const DataBot(this.species, {super.key});
  final Species species;

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.blue,
      child: Text("$h:$w"),
    );
  }
}
