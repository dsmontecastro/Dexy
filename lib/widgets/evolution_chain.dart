import 'package:flutter/widgets.dart';
import 'package:pokedex/extensions/string.dart';

class EvolutionChain extends StatelessWidget {
  const EvolutionChain({super.key, required this.chain});
  final Map<String, dynamic> chain;

  @override
  Widget build(context) {
    final String url = chain["species"]["url"];
    final int id = url.getId();

    return Center(child: Row());
  }
}
