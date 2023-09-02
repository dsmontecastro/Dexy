import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/extensions/string.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/database/models/pokemon.dart';

import 'data_top/background.dart';
import 'data_top/pkmn_sprite.dart';

class DataTop extends StatelessWidget {
  const DataTop(this.pokemon, this.left, {super.key});
  final Pokemon pokemon;
  final double left;

  @override
  Widget build(context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(color: Colors.blue),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          //

          Container(
            width: left * 0.875,
            decoration: const BoxDecoration(color: Colors.green),
            // child:
          ),

          //
          Expanded(
            child: Stack(
              children: [
                Background(pokemon),
                PKMNSprite(pokemon.id),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}

class TypingBox extends StatelessWidget {
  const TypingBox(this.typing, {super.key});
  final Typing typing;

  @override
  Widget build(context) {
    String name = typing.name;
    Color color = typing.color;

    return Container();
  }
}
