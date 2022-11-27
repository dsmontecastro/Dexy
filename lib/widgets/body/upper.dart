import 'package:flutter/material.dart';
import 'package:pokedex/api/pokemon.dart';

class Upper extends StatelessWidget {
  const Upper(this.pokemon, {super.key});
  final Pokemon pokemon;

  @override
  Widget build(context) {
    return Center(child: Text(pokemon.name));

    // return Center(child: Text(pokemon.name));
  }
}
