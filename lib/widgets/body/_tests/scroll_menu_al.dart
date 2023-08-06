import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/services.dart';
import 'package:pokedex/database/models/pokemon.dart';

// class ScrollMenu extends StatefulWidget {
//   const ScrollMenu({super.key});

//   @override
//   ScrollState createState() => ScrollState();
// }

// class ScrollState extends State<ScrollMenu> {
//   @override
//   void initState() {
//     super.initState();
//   }

class ScrollMenu extends StatelessWidget {
  const ScrollMenu({super.key});

  @override
  Widget build(context) {
    // Build Proper
    final Dex dex = context.dex;
    final List<Pokemon> pdex = dex.pokedex;

    final int menuLen = dex.displays;

    final controller = PageController(viewportFraction: 1 / menuLen);

    final double rad = menuLen / 2;

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

        //
        child: AnimatedList(
          // shrinkWrap: true,
          controller: controller,
          initialItemCount: pdex.length,
          itemBuilder: (_, index, anim) {
            return Text(index.toString());
            return ScrollItem(pdex[index]);
          },
        )

        // // Core PageView Widget
        // child: PageView.builder(
        //   // Page Builder

        //   // Scroller Properties
        //   pageSnapping: true,
        //   padEnds: false,
        //   controller: controller,
        //   onPageChanged: cycle,
        //   scrollDirection: Axis.vertical,
        //   physics: const PageScrollPhysics(),

        //   // Item Properties
        //   // itemCount: count,
        //   itemCount: dexLen,
        //   itemBuilder: (context, index) {
        //     return ScrollItem(index, space(index));
        //   },
        // ),
        );
  }
}

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.pokemon, {super.key});
  final Pokemon pokemon;

  @override
  Widget build(context) {
    final int id = context.dex.pokemon.id;
    final bool isPicked = pokemon.id == id;

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Text(
        "${pokemon.id}-${pokemon.name}",
        textAlign: TextAlign.right,
      ),
    );
  }
}
