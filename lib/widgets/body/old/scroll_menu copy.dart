import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/database/services.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollMenu extends StatelessWidget {
  ScrollMenu({super.key});

  final controller = PageController();

  double getSpace(int id, num? center) {
    double space = 0;
    // num? center = controller.page;
    if (center == null) return space;

    num diff = (id - 1 + center).abs();
    if (diff < menuCount) {
      num x = pow(rad, 2) - pow(diff, 2);
      space = sqrt(x.abs()) * 20;
    }

    print("ID#$id @ $center = $space");
    return space;
  }

  @override
  Widget build(context) {
    // Build Proper

    final Dex dex = context.dex;
    final List<Pokemon> pDex = dex.pokedex;

    void cycle(int index) {
      num x = controller.page ?? 0;
      print(x.toInt());
      // if (index < 0 || index >= menuCount) {
      //   context.db.cycleList(index);
      // } else {
      //   context.db.cycleMenu(index);
      // }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Scrollbar(
        // Scrollbar Container

        // Scrollbar Settings
        thumbVisibility: true,

        controller: controller,

        // Core PageView Widget
        child: PageView.builder(
          // child: ListView.builder(
          // Page Builder

          // Scroller Properties
          pageSnapping: true,
          controller: controller,
          scrollDirection: Axis.vertical,
          physics: const PageScrollPhysics(),

          // onPageChanged: cycle,

          // Item Properties
          // itemCount: count,
          itemCount: pDex.length,
          itemBuilder: (context, id) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 50),
              padding: EdgeInsets.only(left: getSpace(id + 1, controller.page)),
              child: ScrollItem(pDex[id]),
            );
          },
        ),
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.pokemon, {super.key});
  final Pokemon pokemon;

  @override
  Widget build(context) {
    final int id = pokemon.id;
    final int curr = context.dex.pokemon.id;

    final bool flag = curr == id;

    return Container(
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
    );
  }
}
