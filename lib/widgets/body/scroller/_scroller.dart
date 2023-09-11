import 'package:flutter/material.dart';
import 'package:pokedex/extensions/color.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

import 'list.dart';
import 'search.dart';

const int menuCount = Dex.menuCount;

class Scroller extends StatefulWidget {
  const Scroller(this.bar, {super.key});
  final double bar;

  @override
  createState() => ScrollerState();
}

class ScrollerState extends State<Scroller> {
  //

  static final baseColor = Colors.grey.shade800;
  static const bgColor = Colors.grey;

  static final PageController controller = PageController(
    viewportFraction: 0.0925,
    initialPage: 0,
  );

  // Index State -----------------------------------------------------------

  int index = 0;

  void scroll(int i) {
    setState(() {
      index = i;
      context.db.scroll(index);
    });
  }

  @override
  Widget build(context) {
    final double bar = widget.bar;

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight - bar;
      final double width = constraints.maxWidth;

      final double maxGap = width * 0.3;
      final double padV = height * 0.01;

      // Layout Components -----------------------------------------------------

      final panel = Container(height: padV, color: bgColor);

      final borderV = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [panel, panel],
      );

      final borderC = ClipPath(
        clipper: const RoundRight(0.6),
        child: Container(
          width: maxGap * 1.5,
          height: height,
          color: bgColor,
        ),
      );

      final borderL1 = ClipPath(
        clipper: const SlantVerticalRight(0.6, 0.2),
        child: Container(
          width: maxGap * 0.8,
          height: height,
          color: baseColor.withLightness(0.2),
        ),
      );

      final borderL2 = ClipPath(
        clipper: const SlantVerticalRight(0.6, 0.2),
        child: Container(
          width: maxGap * 0.5,
          height: height,
          color: baseColor,
        ),
      );

      final gear = Container(
        width: maxGap * 1.5,
        height: height,
        alignment: Alignment.centerLeft,
        child: Stack(children: [
          Positioned(
            left: -maxGap * 1.4,
            height: height,
            child: Transform.rotate(
              angle: index % 360,
              child: Image.asset(
                "assets/images/gear.png",
                width: maxGap * 2.5,
                height: maxGap * 2.5,
                color: baseColor.withLightness(0.4),
              ),
            ),
          )
        ]),
      );

      final pointer = Container(
        width: maxGap * 1.25,
        height: height * 1,
        alignment: Alignment.centerRight,
        child: ClipPath(
          clipper: const TriangleRight(0.2),
          child: Container(
            width: maxGap / 2.5,
            height: maxGap / 2,
            color: baseColor,
          ),
        ),
      );

      return Column(
        children: [
          SearchField(bar, controller),
          Expanded(
            child: Container(
              color: bgColor,
              constraints: const BoxConstraints.expand(),
              child: Stack(children: [
                ScrollList(maxGap, padV, controller, scroll),
                IgnorePointer(child: borderV),
                IgnorePointer(child: borderC),
                IgnorePointer(child: borderL1),
                IgnorePointer(child: gear),
                IgnorePointer(child: borderL2),
                IgnorePointer(child: pointer),
              ]),
            ),
          ),
        ],
      );

      //
    });
  }
}
