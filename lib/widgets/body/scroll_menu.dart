import 'package:flutter/material.dart';
import 'package:pokedex/extensions/provider.dart';

import '../../database/models/pokemon.dart';

class ScrollMenu extends StatelessWidget {
  const ScrollMenu({super.key});

  @override
  Widget build(context) {
    // Build Proper

    final int count = context.dex.items;
    final controller = PageController(viewportFraction: 1 / count);

    void cycle(int index) {
      if (index < 0 || index >= count) {
        context.dex.cycleList(index);
      } else {
        context.dex.cycleIndex(index);
      }
    }

    return Scrollbar(
      // Scrollbar Container

      // Scrollbar Settings
      thumbVisibility: true,
      controller: controller,

      // Core PageView Widget
      child: ListView.builder(
        // Page Builder

        // Scroller Properties
        // padEnds: false,
        controller: controller,
        // onPageChanged: cycle,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),

        // Item Properties
        itemCount: count,
        itemBuilder: (context, index) {
          return PokemonItem(index);
        },
      ),
    );
  }
}

class PokemonItem extends StatelessWidget {
  const PokemonItem(this.id, {super.key});
  final int id;

  @override
  Widget build(context) {
    int index = context.dex.listIndex + id;
    bool isPicked = context.dex.itemIndex == id;
    Pokemon pokemon = context.dex.get(index) ?? context.dex.fill;

    return Transform.scale(
      scale: isPicked ? 1 : 0.8,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: (isPicked) ? 200 : 100,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
          child: Text(
            "${pokemon.id}-${pokemon.name}",
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
