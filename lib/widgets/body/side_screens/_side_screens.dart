import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pokedex/widgets/_misc/page_buttons.dart';

import '_pages.dart';

class SideScreens extends StatefulWidget {
  const SideScreens(this.barHeight, {super.key});
  final double barHeight;

  @override
  createState() => SideScreensState();
}

class SideScreensState extends State<SideScreens> {
  //

  // Constants -----------------------------------------------------------------

  static const duration = Duration(milliseconds: 150);
  static const curve = Curves.linear;

  static const physics = ScrollPhysics();

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
            return pageList[index](widget.barHeight);
          },
        ),

        //
        PageButtons(
          padding: EdgeInsets.only(top: widget.barHeight),
          prev: prevPage,
          next: nextPage,
          shaded: true,
        ),

        //
      ],
    );
  }
}
