import 'package:flutter/material.dart';

import '_sprites.dart';
import 'package:pokedex/extensions/provider.dart';

// import 'package:pokedex/extensions/string.dart';
// import 'package:pokedex/database/models/item.dart';
import 'package:pokedex/database/models/pokemon.dart';

class MainItem extends StatelessWidget {
  const MainItem({super.key});

  @override
  Widget build(context) {
    Pokemon pokemon = context.dex.pokemon;

    // return Center(child: Text(pokemon.name));
    return const Center(
      child: Column(
        children: [
          PokemonSprite(),
        ],
      ),
    );

    // List<Item> items = context.dex.items;
    // return Center(child: Text("${items.length}"));

    //   Image sprite = alpha;

    //   if (items.isNotEmpty) {
    //     Uint8List? data = items[0].getImage();
    //     if (data != null) sprite = Image.memory(data);
    //   }
    //   return Center(child: sprite);
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
    Pokemon pokemon = context.dex.pokemon;
    String? sprite = pokemon.sprite;
    String? shiny = pokemon.shiny;
    bool online = context.online;

    return Column(
      children: [
        IconButton(icon: icon, onPressed: toggleShiny),
        Sprites.getSprite(isShiny ? shiny : sprite, online: online),
      ],
    );
  }
}
