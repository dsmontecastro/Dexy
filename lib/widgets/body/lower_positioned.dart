import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:pokedex/api/pokemon.dart';

class Lower extends StatefulWidget {
  const Lower(this.pokedex, this.updater, {super.key});
  final List<Pokemon> pokedex;
  final Function(int) updater;

  @override
  LowerState createState() => LowerState();
}

class LowerState extends State<Lower> {
  static final ItemScrollController itemController = ItemScrollController();
  static final ItemPositionsListener itemPositions = ItemPositionsListener.create();

  @override
  Widget build(context) {
    List<Pokemon> pokedex = widget.pokedex;

    bool scrollTracker(Notification notification) {
      if (notification is ScrollEndNotification) {
        int index = itemPositions.itemPositions.value.first.index;
        widget.updater(index + 1);
        // itemController.jumpTo(index: index, alignment: 0.5);
        // itemController.scrollTo(
        //     index: index, alignment: 0.5, duration: const Duration(seconds: 1));
        print(index);
        return true;
      }
      return false;
    }

    return Container(
      child: NotificationListener(
        onNotification: scrollTracker,
        child: ScrollablePositionedList.builder(
          itemPositionsListener: itemPositions,
          itemScrollController: itemController,
          itemCount: pokedex.length,
          itemBuilder: ((context, index) => Text("$index-${pokedex[index].name}")),
          // itemBuilder: ((context, itemIndex) {
          //   int scrollIndex = itemPositions.itemPositions.value.first.index;
          //   bool isPicked = itemIndex == scrollIndex;
          //   return PokemonItem(pokemon: pokedex[itemIndex], isPicked: isPicked);
          // }),
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
    // required this.itemIndex,
  });
  // final int itemIndex;
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
