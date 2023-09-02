import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/body/side_screens/_test.dart';

import 'side_screens/pages/scroller.dart';

class SideScreens extends StatefulWidget {
  const SideScreens(this.barHeight, {super.key});
  final double barHeight;

  @override
  createState() => SideScreensState();
}

class SideScreensState extends State<SideScreens> {
  //

  int page = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    final double barHeight = widget.barHeight;
    pages = [Scroller(barHeight), ...testPages];
    super.initState();
  }

  // PageView Elements ---------------------------------------------------------

  late final PageController controller = PageController(initialPage: 0);
  static const duration = Duration(milliseconds: 150);
  static const physics = ScrollPhysics();

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

  // Button Icons --------------------------------------------------------------

  static const Icon _iconRight = Icon(Icons.arrow_right);
  static const Icon _iconLeft = Icon(Icons.arrow_left);

  // Swipe Detection -----------------------------------------------------------

  @override
  Widget build(context) {
    //

    final scrollBehavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );

    final pageView = PageView.builder(
      dragStartBehavior: DragStartBehavior.start,
      scrollBehavior: scrollBehavior,
      controller: controller,
      physics: physics,
      itemBuilder: (_, i) => pages[i % pages.length],
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
