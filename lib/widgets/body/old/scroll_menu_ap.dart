import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/database/services.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollMenu extends StatelessWidget {
  const ScrollMenu({super.key});

  @override
  Widget build(context) {
    // Build Proper

    final Dex dex = context.dex;
    final List<Pokemon> pDex = dex.pokedex;

    final controller = PageController(viewportFraction: 1 / menuCount);

    void cycle(int index) {
      if (index < 0 || index >= menuCount) {
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
        itemCount: pDex.length,
        itemBuilder: (context, id) {
          return ScrollItem(pDex[id]);
        },
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.pokemon, {super.key});
  final Pokemon pokemon;

  double space(double y) {
    num diff = pow(rad, 2) - pow(y, 2);
    return sqrt(diff.abs()) + 100;
  }

  @override
  Widget build(context) {
    final int id = pokemon.id;
    final int curr = context.dex.pokemon.id;

    final bool flag = curr == id;

    // final pos = getCenter

    return AnimatedPadding(
      duration: const Duration(milliseconds: 50),
      padding: EdgeInsets.only(left: space(id)),
      child: Container(
        width: flag ? 200 : 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: flag ? Colors.black : Colors.red,
        ),
        child: Text(
          "${pokemon.id}-${pokemon.name}",
          textAlign: TextAlign.right,
          style: TextStyle(color: flag ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
