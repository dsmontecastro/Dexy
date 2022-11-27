import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'package:pokedex/api/pokemon.dart';

class Lower extends StatefulWidget {
  const Lower(this.pokedex, this.updater, {super.key});
  final List<Pokemon> pokedex;
  final Function(int) updater;

  @override
  LowerState createState() => LowerState();
}

class LowerState extends State<Lower> {
  static const int menuSize = 5;

  static int pokeIndex = 0; // Pokedex Index as top of List
  static int menuIndex = 0; // Menu Index from 0 to menuSize

  static const ScrollPhysics physics = ScrollPhysics();
  static final ScrollController controller = ScrollController(initialScrollOffset: 50.0);

  @override
  Widget build(context) {
    final List<Pokemon> pokedex = widget.pokedex;

    return Center(
      child: ScrollSnapList(
          shrinkWrap: true,
          selectedItemAnchor: SelectedItemAnchor.MIDDLE,
          updateOnScroll: true,
          focusOnItemTap: true,
          focusToItem: widget.updater,
          scrollDirection: Axis.vertical,
          itemSize: 100,
          itemCount: (pokedex.length / 10).round(),
          onItemFocus: widget.updater,
          itemBuilder: (context, index) {
            return Text("$index-${pokedex[index].name}");
          }),
    );
  }
}

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.pokemon,
    required this.isPicked,
    required this.itemIndex,
  });
  final int itemIndex;
  final bool isPicked;
  final Pokemon? pokemon;

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: (isPicked) ? 200 : 100,
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: Text(
          "${pokemon?.name}",
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
