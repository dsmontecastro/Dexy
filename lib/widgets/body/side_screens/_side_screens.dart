import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pokedex/widgets/_misc/page_buttons.dart';

import 'pages.dart';
import 'scroller/_scroller.dart';

class SideScreens extends StatefulWidget {
  const SideScreens(this.barHeight, {super.key});
  final double barHeight;

  @override
  createState() => SideScreensState();
}

class SideScreensState extends State<SideScreens> {
  //

  // Constants -----------------------------------------------------------------

  static const physics = ScrollPhysics();
  static const duration = Duration(milliseconds: 150);
  static const curve = Curves.linear;

  static const double padH = 0.09;
  static const double padV = 0.075;

  // PageView Elements & Controllers -------------------------------------------

  static final initialPage = pageCount * 999;

  int page = initialPage;
  final controller = PageController(initialPage: initialPage);

  void onPageChanged(int i) {
    setState(() => page = i);
  }

  void nextPage() => turnPage(1);
  void prevPage() => turnPage(-1);

  void turnPage(int i) {
    setState(() {
      page += i;
      controller.animateToPage(
        page,
        curve: curve,
        duration: duration,
      );
    });
  }

  @override
  Widget build(context) {
    final double padBar = widget.barHeight;
    // const padding = EdgeInsets.symmetric(horizontal: padH, vertical: padV);

    return Scroller(padBar);

    return Stack(
      children: [
        //

        //
        PageView.builder(
          dragStartBehavior: DragStartBehavior.start,
          onPageChanged: onPageChanged,
          controller: controller,
          physics: physics,
          itemBuilder: (_, i) {
            final int index = i % pageCount;
            return pageList[index](padBar, padH, padV);
          },
        ),

        //
        PageButtons(
          pads: EdgeInsets.only(top: padBar),
          prev: prevPage,
          next: nextPage,
          spaceH: padH,
          spaceV: padV,
          shaded: true,
        ),

        //
      ],
    );
  }
}
