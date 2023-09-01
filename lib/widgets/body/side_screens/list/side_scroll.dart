import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/providers/dex.dart';

import 'scroll_item.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class SideScroll extends StatefulWidget {
  const SideScroll({super.key});

  @override
  SideScrollState createState() => SideScrollState();
}

class SideScrollState extends State<SideScroll> {
  final PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.1,
  );

  late final int limit;

  @override
  void initState() {
    limit = context.db.dexCount;
    super.initState();
  }

  int index = 0;
  void scroll(int i) {
    setState(() {
      index = i;
      context.db.scroll(index);
    });
  }

  void scrollTo(int i) {
    if (i > 0 && i < limit) {
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
    final Widget divider = SizedBox(
      width: size.width / 15,
      height: size.height / menuCount / 5,
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: size.height / 15),
      decoration: const BoxDecoration(
        color: Colors.green,
      ),

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
              padding: EdgeInsets.only(left: size.width / 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [divider, ScrollItem(id, size)],
              ),
            );
          },
        ),
      ),
    );
  }
}
