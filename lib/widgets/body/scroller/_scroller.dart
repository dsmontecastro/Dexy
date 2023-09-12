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

  // Angle State -----------------------------------------------------------

  double angle = 0;

  void scroll(int i) {
    setState(() => angle = i % 360);
    context.db.scroll(i);
  }

  @override
  Widget build(context) {
    final double bar = widget.bar;

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight - bar;
      final double width = constraints.maxWidth;

      final double maxGap = width * 0.3;
      final double padV = height * 0.02;

      // Layout Components -----------------------------------------------------

      final vPanels = Container(height: padV, color: bgColor);

      final Widget layoutDesigns = IgnorePointer(
        child: Stack(
          children: [
            //

            // Vertical Pads
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [vPanels, vPanels],
            ),

            // Circular Pad
            ClipPath(
              clipper: const RoundRight(0.6),
              child: Container(
                height: height,
                width: maxGap * 1.5,
                color: bgColor,
              ),
            ),

            // Left-Under Pad
            ClipPath(
              clipper: const SlantVerticalRight(0.3, 0.25),
              child: Container(
                height: height,
                width: maxGap * 0.9,
                color: baseColor.withLightness(0.2),
              ),
            ),

            // Spin-Gear
            Container(
              height: height,
              width: maxGap * 1.1,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    height: height,
                    width: width / 2,
                    child: Transform.rotate(
                      angle: angle,
                      child: Image.asset(
                        "assets/images/gear.png",
                        color: baseColor.withLightness(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Left-Over Pad
            ClipPath(
              clipper: const SlantVerticalRight(0.6, 0.2),
              child: Container(
                height: height,
                width: maxGap * 0.5,
                color: baseColor,
              ),
            ),

            // Pointer
            Container(
              height: height,
              width: maxGap * 1.26,
              // color: Colors.blue.withOpacity(0.9),
              alignment: Alignment.centerRight,
              child: ClipPath(
                clipper: const TriangleRight(0.2),
                child: Container(
                  height: maxGap / 2,
                  width: maxGap / 2,
                  color: baseColor,
                ),
              ),
            ),

            //
          ],
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
                layoutDesigns,
              ]),
            ),
          ),
        ],
      );

      //
    });
  }
}
