import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/providers/dex.dart';

import 'item.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollerBody extends StatefulWidget {
  const ScrollerBody({super.key});

  @override
  ScrollerBodyState createState() => ScrollerBodyState();
}

class ScrollerBodyState extends State<ScrollerBody> {
  //

  int index = 0;

  void scroll(int i) {
    setState(() {
      index = i;
      context.db.scroll(index);
    });
  }

  // PageView Controller -------------------------------------------------------

  final PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.1,
  );

  void scrollTo(int i) {
    if (i > 0 && i < context.db.dexCount) {
      controller.animateToPage(
        i,
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  Widget build(context) {
    // Build Proper

    final Size size = MediaQuery.of(context).size;

    final double padV = size.height / 15;
    final double padH = 50;
    final padding = EdgeInsets.fromLTRB(padH + 20, padV, padH, padV);

    return Container(
      width: double.infinity,
      // height: double.infinity,
      alignment: Alignment.centerLeft,
      color: Colors.green,
      padding: padding,

      // Scrollbar Container
      child: Scrollbar(
        // Scrollbar Settings
        thumbVisibility: true,
        trackVisibility: true,
        controller: controller,

        // Core List
        child: PageView.builder(
          // Scroller Properties
          padEnds: true,
          pageSnapping: true,
          onPageChanged: scroll,
          controller: controller,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,

          // Item Properties
          itemCount: context.dex.dexCount,
          itemBuilder: (_, id) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ScrollItem(id, size),
            );
            // padding: EdgeInsets.only(left: size.width / 8),
            // padding: EdgeInsets.zero,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [divider, ScrollItem(id, size)],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
