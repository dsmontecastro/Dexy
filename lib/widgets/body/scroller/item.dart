import 'dart:math';
import 'package:flutter/material.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.id, this.maxGap, {super.key});
  final double maxGap;
  final int id;

  static const duration = Duration(milliseconds: 0);

  double getGap(int index) {
    int diff = (index - id).abs();
    double gap = 0;
    if (diff <= rad) {
      gap = sqrt((pow((rad + 1), 2) - pow(diff, 2)).abs());
      gap -= 1;
    }
    return maxGap * gap / rad;
  }

  @override
  Widget build(context) {
    final Dex dex = context.dex;
    final int index = dex.dexIndex;

    final bool flag = index == id;
    final Species pkmn = dex.getSpecies(id);

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      final double gap = getGap(index);

      return Container(
        // width: width / 15,
        // height: height * 0.1,
        // duration: duration,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10, left: gap),
        decoration: BoxDecoration(
          color: flag ? Colors.black : Colors.red,
        ),
        child: Text(
          "${pkmn.id}-${pkmn.name}",
          textAlign: TextAlign.right,
          style: TextStyle(color: flag ? Colors.white : Colors.black),
        ),
      );

      //
    });

    //
  }
}
