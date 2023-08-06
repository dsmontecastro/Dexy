import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/models/pokemon.dart';

class ScrollMenu extends StatelessWidget {
  const ScrollMenu({super.key});

  @override
  Widget build(context) {
    // Build Proper

    final int count = context.dex.displays;
    // final controller = PageController(viewportFraction: 1 / count);
    final ScrollController controller = ScrollController();

    final int dexLen = context.dex.pokedex.length;
    final int menuLen = context.dex.displays;

    final double rad = menuLen / 2;
    final double width = MediaQuery.of(context).size.width / 4;

    double space(int i) {
      num diff = pow(rad, 2) - pow(i, 2);
      return sqrt(diff.abs());
    }

    void scroll(int index) {
      print(index);
      // if (index < 0 || index >= count) {
      //   context.dex.cycleList(index);
      // } else {
      //   context.dex.cycleMenu(index);
      // }
    }

    return Row(
      children: [
        const SizedBox(width: 350),
        Expanded(
          child: ListWheelScrollView(
            onSelectedItemChanged: scroll,
            clipBehavior: Clip.none,
            controller: controller,
            offAxisFraction: 5,
            perspective: 0.002,
            diameterRatio: 5,
            itemExtent: 100,
            children: List.generate(dexLen, (index) => ScrollItem(index, space(index))),
          ),
        ),
      ],
    );
  }
}

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.id, this.spacing, {super.key});
  final double spacing;
  final int id;

  @override
  Widget build(context) {
    final int index = context.dex.listIndex + id;
    final bool isPicked = context.dex.menuIndex == id;
    final Pokemon pokemon = context.dex.get(index);

    return Padding(
      padding: EdgeInsets.only(left: spacing),
      child: Transform.scale(
        scale: isPicked ? 1 : 0.8,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: (isPicked) ? 200 : 100,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              "${pokemon.id}-${pokemon.name}",
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}
