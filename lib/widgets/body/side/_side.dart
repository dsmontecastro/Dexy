import 'package:flutter/material.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class Side extends StatefulWidget {
  const Side({super.key});

  @override
  SideState createState() => SideState();
}

class SideState extends State<Side> {
  final PageController controller = PageController(initialPage: 0);

  int index = 0;
  void setPage(int i) {
    setState(() {
      index = i;
      context.db.scroll(index);
    });
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
          onPageChanged: setPage,
          controller: controller,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,

          // Item Properties
          itemCount: context.dex.count,
          itemBuilder: (_, id) {
            return Padding(
              padding: EdgeInsets.only(left: size.width / 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [divider],
                // children: [divider, ScrollItem(id, size)],
              ),
            );
          },
        ),
      ),
    );
  }
}
