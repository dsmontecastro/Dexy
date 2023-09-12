import 'dart:math';
import 'package:flutter/material.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/types/enums/generation.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.id, this.maxGap, {super.key});
  final double maxGap;
  final int id;

  static const duration = Duration(milliseconds: 100);

  static const path = "assets/pokemon/icons";
  static const blank = AssetImage("$path/0.png");

  double getGap(int index) {
    int diff = (index - id).abs();
    double gap = 0;
    if (diff <= rad) {
      gap = sqrt((pow((rad + 1), 2) - pow(diff, 2)).abs());
      gap -= 1;
    }
    return maxGap * gap / rad / 2;
  }

  @override
  Widget build(context) {
    final int index = context.dex.dexIndex;
    final Species pkmn = context.dex.getSpecies(id);
    final Generation gen = pkmn.generation;

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;

      final double gap = getGap(index);
      final double padV = height * 0.1;

      final double fontSize = height * 0.25;
      final textStyle = TextStyle(color: Colors.white, fontSize: fontSize);
      final buttonStyle = TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );

      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: padV, left: gap),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
            ],
          ),
        ),

        //
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //

            SizedBox(width: width * 0.25),
            SizedBox(
              width: width * 0.1,
              child: FadeInImage(
                fit: BoxFit.fitHeight,
                placeholder: blank,
                image: AssetImage("$path/${pkmn.id}.png"),
                fadeInDuration: duration,
              ),
            ),

            SizedBox(width: width * 0.03),
            SizedBox(
              width: width * 0.15,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  maxLines: 1,
                  pkmn.name.species(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),

            Expanded(child: Container()),

            SizedBox(
              width: width * 0.03,
              child: TextButton(
                onPressed: () async => context.db.caught(pkmn),
                style: buttonStyle,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    pkmn.caught ? "🗹" : "☐",
                    style: textStyle,
                  ),
                ),
              ),
            ),

            SizedBox(width: width * 0.05),

            SizedBox(
              width: width * 0.03,
              child: TextButton(
                onPressed: () async => context.db.favorite(pkmn),
                style: buttonStyle,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    pkmn.favorite ? "★" : "☆",
                    style: textStyle,
                  ),
                ),
              ),
            ),

            SizedBox(width: width * 0.05),
            Expanded(
              child: ClipPath(
                clipper: const SlantLeftDown(0.25),
                child: Container(
                  color: Colors.grey.shade900,
                  height: height,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      gen.index.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Container(color: gen.color, width: (maxGap - gap) / 2.5),

            //
          ],
        ),
      );

      //
    });

    //
  }
}
