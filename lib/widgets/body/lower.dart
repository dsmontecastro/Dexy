import 'package:flutter/material.dart';

import 'package:pokedex/extensions.dart';
import 'package:pokedex/api/pokemon.dart';

class Lower extends StatefulWidget {
  const Lower(this.pokedex, this.setter, this.getter, {super.key});
  final List<Pokemon> pokedex;
  final Function(int) setter;
  final Function getter;

  @override
  LowerState createState() => LowerState();
}

class LowerState extends State<Lower> {
  static const itemCount = 10;

  static final controller = PageController(viewportFraction: 1 / itemCount);

  @override
  Widget build(context) {
    // Build Proper

    // Filler List for PageView Smoothing
    final List<Pokemon> filler = List.generate(
      itemCount - 1,
      (index) => Pokemon.filler(),
    );

    // Pokedex w/ Fillers
    final List<Pokemon> pokedex = widget.pokedex + filler;

    // Index State Modifier
    void updateIndex(int value) {
      int maxValue = widget.pokedex.length;
      if (value.inRange(0, maxValue)) {
        widget.setter(value);
      }
    }

    return Scrollbar(
      // Scrollbar Container

      // Scrollbar Settings
      thumbVisibility: true,
      controller: controller,

      // Core PageView Widget
      child: PageView.builder(
        // Page Builder

        // Scroller Properties
        padEnds: false,
        controller: controller,
        onPageChanged: updateIndex,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),

        // Item Properties
        itemCount: pokedex.length,
        itemBuilder: (context, index) {
          bool isPicked = (index == widget.getter());
          return PokemonItem(pokemon: pokedex[index], isPicked: isPicked);
        },
      ),
    );
  }
}

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.pokemon,
    required this.isPicked,
  });
  final bool isPicked;
  final Pokemon? pokemon;

  @override
  Widget build(context) {
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
            "${pokemon?.id}-${pokemon?.name}",
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
