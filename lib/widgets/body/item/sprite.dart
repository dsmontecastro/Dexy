import 'package:flutter/material.dart';

import 'package:pokedex/widgets/_misc/sprites.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';
import 'package:pokedex/database/models/pokemon.dart';

import 'background.dart';

class PokemonSprite extends StatefulWidget {
  const PokemonSprite(this.side, {super.key});
  final double side;

  @override
  PokemonSpriteState createState() => PokemonSpriteState();
}

class PokemonSpriteState extends State<PokemonSprite> {
  static const Icon icon = Icon(Icons.abc);
  bool isShiny = false;

  void toggleShiny() => setState(() => isShiny = !isShiny);

  @override
  Widget build(context) {
    Species species = context.dex.curr;
    Pokemon pokemon = context.db.getPokemon(species.id);

    String? sprite = pokemon.sprite;
    String? shiny = pokemon.shiny;
    // bool online = context.online;

    final image = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(icon: icon, onPressed: toggleShiny),
        Sprites.getSprite(isShiny ? shiny : sprite, widget.side),
        // Sprites.getSprite(isShiny ? shiny : sprite, online: online),
      ],
    );

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [const SpriteBG(), image],
      ),
    );
  }
}
