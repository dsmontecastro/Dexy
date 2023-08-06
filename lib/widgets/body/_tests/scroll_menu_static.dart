import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/extensions/provider.dart';

import 'package:pokedex/database/services.dart';
import 'package:pokedex/database/models/pokemon.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class ScrollMenu extends StatefulWidget {
  const ScrollMenu({super.key});

  @override
  ScrollState createState() => ScrollState();
}

class ScrollState extends State<ScrollMenu> {
  final PageController controller = PageController(initialPage: 0);
  final int index = 0;

  void scroll(int index) {
    if (index < 0 || index >= menuCount) {
      context.db.cycleList(index);
    } else {
      context.db.cycleMenu(index);
    }
  }

  double getPadding(int i) {
    num diff = pow(rad, 2) - pow(i - rad + 0.5, 2);
    return sqrt(diff.abs()) * 30;
  }

  @override
  Widget build(context) {
    // Build Proper

    final Size size = MediaQuery.of(context).size;
    final Widget divider = SizedBox(
      width: size.width / 15,
      height: size.height / menuCount / 5,
    );

    return Scrollbar(
      // Scrollbar Container

      // Scrollbar Settings
      thumbVisibility: true,
      controller: controller,

      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: size.height / 15),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),

        // Core List
        child: ListView.builder(
          // Scroller Properties
          controller: controller,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),

          // Item Properties
          itemCount: menuCount,
          itemExtent: size.height / menuCount * 0.75,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.only(left: getPadding(index)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [divider, ScrollItem(index, size.width)],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  const ScrollItem(this.index, this.width, {super.key});
  final double width;
  final int index;

  @override
  Widget build(context) {
    final Dex dex = context.dex;

    final int id = dex.listIndex + index;
    final bool flag = dex.currIndex == id;

    final Pokemon pkmn = dex.get(id);

    return Expanded(
      child: Container(
        width: width / 3,
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
