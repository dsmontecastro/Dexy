import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/database/models/species.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollMenu extends StatefulWidget {
  const ScrollMenu({super.key});

  @override
  ScrollState createState() => ScrollState();
}

class ScrollState extends State<ScrollMenu> {
  final PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.1,
  );

  int index = 0;
  void scroll(int i) {
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
          itemCount: context.dex.count,
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

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.id, this.size, {super.key});
  final int id;
  final Size size;

  @override
  Widget build(context) {
    final Dex dex = context.dex;
    final bool flag = dex.index == id;

    final Species pkmn = dex.getSpecies(id);

    return Expanded(
      child: Container(
        width: size.width / 3,
        // height: size.width / menuCount,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: flag ? Colors.black : Colors.red,
        ),
        child: Text(
          "${pkmn.id}-${pkmn.name}",
          textAlign: TextAlign.right,
          style: TextStyle(color: flag ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
