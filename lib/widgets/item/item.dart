import 'package:flutter/material.dart';

import 'nav_drawer.dart';
import '../_body/_sprites.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';
import 'package:pokedex/database/models/pokemon.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: context.navKey,
          body: const PokemonSprite(),
          drawer: NavDrawer(constraints.maxWidth / 3),
        );
      },
    );
  }
}

class PokemonSprite extends StatefulWidget {
  const PokemonSprite({super.key});

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
    bool online = context.online;

    return Center(
      child: Column(
        children: [
          IconButton(icon: icon, onPressed: toggleShiny),
          Sprites.getSprite(isShiny ? shiny : sprite, online: online),
        ],
      ),
    );
  }
}
