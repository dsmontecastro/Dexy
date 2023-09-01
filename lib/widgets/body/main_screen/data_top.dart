import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/database/models/pokemon.dart';

import 'data_top/background.dart';
import 'data_top/pkmn_sprite.dart';

class DataTop extends StatelessWidget {
  const DataTop(this.pokemon, this.wOffset, {super.key});
  final Pokemon pokemon;
  final double wOffset;

  @override
  Widget build(context) {
    final width = wOffset * 0.875;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(color: Colors.blue),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          //

          Container(
            width: width,
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

    // return Container(
    //   constraints: const BoxConstraints.expand(),
    //   child: Row(
    //     textDirection: TextDirection.ltr,
    //     children: [
    //       Stack(
    //         children: [
    //           Background(pokemon),
    //           PKMNSprite(pokemon.id),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // return LayoutBuilder(builder: (context, constraints) {
    //   final width = constraints.maxWidth;
    //   final height = constraints.maxHeight;

    //   return Stack(
    //     children: [
    //       Container(height: height, color: Colors.grey.shade900),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Flexible(flex: 1, child: TitleOrder(order)),
    //           Flexible(flex: 2, child: TitleInfo(name, genus)),
    //         ],
    //       ),
    //     ],
    //   );

    //
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
