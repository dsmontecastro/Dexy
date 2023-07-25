import 'package:flutter/material.dart';
import 'package:pokedex/extensions/provider.dart';

import '../../database/models/pokemon.dart';

class ScrollItem extends StatelessWidget {
  const ScrollItem({super.key});

  @override
  Widget build(context) {
    Pokemon pokemon = context.dex.item ?? context.dex.fill;

    return Center(child: Text(pokemon.name));
  }
}
