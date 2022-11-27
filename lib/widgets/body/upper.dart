import 'package:flutter/material.dart';
import 'package:pokedex/api/pokemon.dart';

class Upper extends StatelessWidget {
  const Upper(this.pokemon, {super.key});
  final Pokemon pokemon;

  // Future<Pokemon> getPokemon() async => Pokemon.create(name);

  @override
  Widget build(context) {
    return Center(child: Text(pokemon.name));
    // return FutureBuilder<Pokemon>(
    //     // future: getPokemon(),
    //     builder: (context, snapshot) {
    //   Widget main = const CircularProgressIndicator();
    //   if (snapshot.hasData) {
    //     main = Text(snapshot.data!.name);
    //   } else {
    //     main = Text("${snapshot.error}");
    //   }
    //   return Center(child: main);
    // });
  }
}
