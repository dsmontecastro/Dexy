import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

import 'item.dart';

class ScrollList extends StatelessWidget {
  const ScrollList(this.maxGap, this.padV, this.controller, this.scroll, {super.key});
  final PageController controller;
  final Function(int) scroll;
  final double maxGap;
  final double padV;

  static const physics = ClampingScrollPhysics();

  @override
  Widget build(context) {
    List<Species> pokedex = context.dex.pokedex;
    int count = pokedex.length;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, padV, 5, padV),

      child: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: PageView.builder(
            padEnds: true,
            pageSnapping: true,
            allowImplicitScrolling: true,

            physics: physics,
            onPageChanged: scroll,
            controller: controller,
            scrollDirection: Axis.vertical,

            // List Items
            itemCount: count,
            itemBuilder: (_, id) {
              return ScrollItem(id, maxGap);
            },

            //
          ),
        ),
      ),

      //
    );
  }
}
