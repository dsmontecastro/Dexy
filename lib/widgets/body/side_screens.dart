import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'side_screens/_pages.dart';

class SideScreens extends StatefulWidget {
  const SideScreens(this.barHeight, {super.key});
  final double barHeight;

  @override
  createState() => SideScreensState();
}

class SideScreensState extends State<SideScreens> {
  //

  // Constants -----------------------------------------------------------------

  static const Icon _iconRight = Icon(Icons.arrow_right);
  static const Icon _iconLeft = Icon(Icons.arrow_left);

  static const duration = Duration(milliseconds: 150);
  static const physics = ScrollPhysics();

  // Page & PageView Control ---------------------------------------------------

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
        curve: Curves.linear,
        duration: duration,
      );
    });
  }

  @override
  Widget build(context) {
    //

    final scrollBehavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
    );

    final pageView = PageView.builder(
      dragStartBehavior: DragStartBehavior.start,
      scrollBehavior: scrollBehavior,
      onPageChanged: onPageChanged,
      controller: controller,
      physics: physics,
      itemBuilder: (_, i) => pageList[i % pageCount](widget.barHeight),
    );

    final buttons = Container(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.only(top: widget.barHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageButton(_iconLeft, prevPage),
            PageButton(_iconRight, nextPage),
          ],
        ),
      ),
    );

    return Stack(children: [pageView, buttons]);
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.icon, this.func, {super.key});
  final Function() func;
  final Icon icon;

  static final shade = BoxDecoration(
    color: Colors.black.withOpacity(0.3),
  );

  @override
  Widget build(context) {
    return Container(
      decoration: shade,
      height: double.infinity,
      child: IconButton(
        icon: icon,
        color: Colors.grey,
        onPressed: func,
      ),
    );
  }
}
