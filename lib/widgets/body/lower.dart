import 'package:flutter/material.dart';

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
  static final controller = PageController(viewportFraction: 0.1);

  @override
  Widget build(context) {
    final List<Pokemon> pokedex = widget.pokedex;

    return Center(
      // alignment: Alignment.topCenter,
      child: PageView.builder(
        // Scroller Data
        padEnds: false,
        controller: controller,
        onPageChanged: widget.setter,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),

        // Item Data
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
