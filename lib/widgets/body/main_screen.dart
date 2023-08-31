import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/database/models/species.dart';
import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/widgets/body/main_screen/title.dart';

import 'main_screen/background.dart';
import 'main_screen/pkmn_sprite.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int variety = 0;

  @override
  Widget build(context) {
    Species species = context.dex.curr;
    List<int> varieties = species.varieties;

    int id = 0;
    if (varieties.isNotEmpty) id = varieties[variety];

    Pokemon pokemon = context.db.getPokemon(id);
    Typing type1 = pokemon.type1;
    Typing type2 = pokemon.type2;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      constraints: const BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Center(
        child: Column(
          children: [
            //

            //
            Expanded(
              flex: 2,
              child: TitleBar(species, type1, type2),
            ),

            //
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  PKMNSprite(id),
                  Background(pokemon),
                ],
              ),
            ),

            //
            Expanded(
              flex: 3,
              child: Text("BOT"),
            ),

            //
          ],
        ),
      ),
    );
  }
}
