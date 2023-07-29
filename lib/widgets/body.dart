import 'package:flutter/material.dart';

import 'body/main_item.dart';
import 'body/scroll_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  static const List<Widget> children = [MainItem(), ScrollMenu()];

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isVertical = orientation == Orientation.portrait;
        final Axis direction = isVertical ? Axis.vertical : Axis.horizontal;

        return Flex(
          direction: direction,
          children: List.generate(
            children.length,
            (int i) => Expanded(child: Center(child: children[i])),
          ),
        );
      },
    );
  }
}
