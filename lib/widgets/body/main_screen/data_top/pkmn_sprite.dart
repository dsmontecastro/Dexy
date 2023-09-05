import 'package:flutter/material.dart';

import 'package:pokedex/database/models/pokemon.dart';

class PKMNSprite extends StatelessWidget {
  const PKMNSprite(this.pokemon, this.isShiny, {super.key});
  final Pokemon pokemon;
  final bool isShiny;

  static const String path = "assets/pokemon";

  String getType(bool flag) {
    if (flag) {
      return "shinies";
    } else {
      return "sprites";
    }
  }

  @override
  Widget build(context) {
    final int id = pokemon.id;
    final String loc = "$path/${getType(isShiny)}";

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Image.asset(
        "$loc/$id.png",
        fit: BoxFit.fitWidth,
        gaplessPlayback: true,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) {
          if (isShiny) {
            return Image.asset("${getType(!isShiny)}/$id.png");
          } else {
            return Image.asset("$loc/0.png");
          }
        },
      ),
    );
  }
}
