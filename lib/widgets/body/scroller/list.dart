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

  // static final PageController controller = PageController(
  //   initialPage: 0,
  //   viewportFraction: 0.0925,
  // );

  // void scroller(int i) {
  //   scroll(i);
  //   if (controller.page != i) {
  //     controller.jumpToPage(i);
  //   }
  // }

  @override
  Widget build(context) {
    List<Species> pokedex = context.dex.pokedex;
    int count = pokedex.length;

    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: controller,

      child: Container(
        padding: EdgeInsets.fromLTRB(0, padV * 2, 20, 0),
        child: PageView.builder(
          padEnds: true,
          physics: physics,
          pageSnapping: true,
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

      //
    );
  }
}
