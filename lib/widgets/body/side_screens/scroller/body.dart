import 'package:flutter/material.dart';
import 'package:pokedex/extensions/color.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

import 'item.dart';

const int menuCount = Dex.menuCount;

class ScrollerBody extends StatelessWidget {
  const ScrollerBody({super.key});

  static const color = Colors.grey;

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;

      final double padV = height * 0.01;
      final double maxGap = width * 0.3;

      final panel = Container(height: padV, color: color);

      final borderV = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [panel, panel],
      );

      final borderL = ClipPath(
        clipper: const SlantVerticalRight(0.6, 0.2),
        child: Container(
          width: maxGap * 0.5,
          height: height,
          color: color.withLightness(0.3),
        ),
      );

      final borderC1 = ClipPath(
        clipper: const RoundRight(0.6),
        child: Container(
          width: maxGap * 1.5,
          height: height,
          color: color,
        ),
      );

      final borderC2 = Container(
        alignment: Alignment.centerLeft,
        child: ClipPath(
          clipper: const RoundRight(0.2),
          child: Container(
            width: maxGap * 1.5,
            height: height * 0.9,
            color: color.withLightness(0.2),
          ),
        ),
      );

      // final circle = Container(
      //   width: maxGap,
      //   height: height,
      //   alignment: Alignment.center,
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(300.0),
      //     child: Container(
      //       width: maxGap * 0.8,
      //       height: maxGap * 0.8,
      //       color: color.withLightness(0.4),
      //     ),
      //   ),
      // );

      final pointer = Container(
        width: maxGap * 1.15,
        height: height * 1,
        alignment: Alignment.centerRight,
        child: ClipPath(
          clipper: const TriangleRight(0.2),
          child: Container(
            width: maxGap / 2,
            height: maxGap / 2,
            color: color.withLightness(0.3),
          ),
        ),
      );

      return Container(
        color: color,
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          ScrollList(maxGap, padV),
          IgnorePointer(child: borderV),
          IgnorePointer(child: borderC1),
          IgnorePointer(child: borderC2),
          IgnorePointer(child: borderL),
          IgnorePointer(child: pointer),
        ]),
      );

      //
    });
  }
}

class ScrollList extends StatefulWidget {
  const ScrollList(this.maxGap, this.padV, {super.key});
  final double maxGap;
  final double padV;

  @override
  createState() => ScrollListState();
}

class ScrollListState extends State<ScrollList> {
  int index = 0;

  void scroll(int i) {
    setState(() {
      index = i;
      context.db.scroll(index);
    });
  }

  // PageView Controller -------------------------------------------------------

  static const physics = ClampingScrollPhysics();

  final PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.0925,
  );

  @override
  Widget build(context) {
    final double maxGap = widget.maxGap;
    final double padV = widget.padV / 2;

    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: controller,

      child: Container(
        padding: EdgeInsets.fromLTRB(0, padV * 4, 20, 0),
        // padding: const EdgeInsets.only(right: 20),
        child: PageView.builder(
          padEnds: true,
          physics: physics,
          pageSnapping: true,
          onPageChanged: scroll,
          controller: controller,
          scrollDirection: Axis.vertical,

          // List Items
          itemCount: context.dex.dexCount,
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
