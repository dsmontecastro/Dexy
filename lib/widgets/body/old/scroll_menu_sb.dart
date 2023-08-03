import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/models/pokemon.dart';

class ScrollMenu extends StatelessWidget {
  const ScrollMenu({super.key});

  @override
  Widget build(context) {
    // Build Proper

    final int dexLen = context.dex.pokedex.length;
    final int menuLen = context.dex.displays;

    final controller = PageController(viewportFraction: 1 / menuLen);

    final double rad = menuLen / 2;
    final double width = MediaQuery.of(context).size.width / 4;

    double space(int i) {
      num diff = pow(rad, 2) - pow(i, 2);
      return sqrt(diff.abs());
    }

    void cycle(int index) {
      if (index < 0 || index >= menuLen) {
        context.db.cycleList(index);
      } else {
        context.db.cycleMenu(index);
      }
    }

    return Scrollbar(
      // Scrollbar Container

      // Scrollbar Settings
      thumbVisibility: true,
      controller: controller,

      // Core PageView Widget
      child: PageView.builder(
        // Page Builder

        // Scroller Properties
        pageSnapping: true,
        padEnds: false,
        controller: controller,
        onPageChanged: cycle,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),

        // Item Properties
        // itemCount: count,
        itemCount: dexLen,
        itemBuilder: (context, index) {
          return ScrollItem(index, space(index));
        },
      ),
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
