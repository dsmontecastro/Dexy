import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:pokedex/extensions.dart';
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

  void update(int value) {
    setState(() {
      menuIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    final List<Pokemon> pokedex = widget.pokedex;
    final int max = pokedex.length;

    void scroller(int value) {
      print(value);
      int index = (controller.offset / 100.0).round() + 1;
      widget.updater(index);
    }

    var itemController = ItemScrollController();

    var x = ScrollablePositionedList.builder(
        itemCount: widget.pokedex.length,
        itemBuilder: ((context, index) => Text("$index-${pokedex[index].name}")));
    // return Center(
    //   child: Wheel
    // );

    return Center(
      child: ListWheelScrollView(
        itemExtent: 25.0,
        // squeeze: 1.5,
        perspective: 0.0005,
        diameterRatio: 1.5,
        offAxisFraction: 0,
        clipBehavior: Clip.antiAlias,
        // child: SingleChildScrollView(
        controller: controller,
        // child: Column(
        onSelectedItemChanged: scroller,
        // onSelectedItemChanged: (value) {
        //   // update(value);
        //   widget.updater(value);
        //   controller.jumpTo(value as double);
        // },
        children: List.generate(max, (index) {
          int itemIndex = pokeIndex + index;
          bool isPicked = index == menuIndex;
          Pokemon? pokemon = itemIndex.inRange(0, max) ? pokedex[itemIndex] : null;
          return PokemonItem(pokemon: pokemon, itemIndex: itemIndex, isPicked: isPicked);
        }),
        // ),
      ),
    );
    // var x = ScrollUpdateNotification(metrics: metrics, context: context)

    return Center(
      // child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: physics,
              controller: controller,
              itemCount: widget.pokedex.length,
              itemBuilder: ((context, index) {
                return Text("$index-${pokedex[index].name}");
              }),
            ),
          ],
        ),
      ),
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
