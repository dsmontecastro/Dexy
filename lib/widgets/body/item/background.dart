import 'package:flutter/material.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/pokemon.dart';

class SpriteBG extends StatelessWidget {
  const SpriteBG({super.key});

  @override
  Widget build(context) {
    //

    final Pokemon pokemon = context.dex.getCurrentPokemon();
    final Color type1 = pokemon.type1.color;
    final Color type2 = pokemon.type2.color;

    final typeColor = Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.45, 0.55, 1.0],
          colors: [
            type1.withOpacity(1),
            type1.withOpacity(0.5),
            type2.withOpacity(0.5),
            type2.withOpacity(1),
          ],
        ),
      ),
    );

    final bg = Positioned.fill(
      child: Image.asset(
        'assets/images/hex.png',
        repeat: ImageRepeat.repeat,
        color: const Color.fromARGB(255, 72, 72, 72).withOpacity(0.5),
      ),
    );

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [bg, typeColor],
      ),
    );
  }
}
