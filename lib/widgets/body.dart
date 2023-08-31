import 'package:flutter/material.dart';

import 'body/main_screen.dart';
import 'body/side_screens.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  static const List<Widget> children = [MainScreen(), SideScreen()];

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final Size size = MediaQuery.of(context).size;
        final bool isVertical = orientation == Orientation.portrait;
        final Axis direction = isVertical ? Axis.vertical : Axis.horizontal;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Flex(
            direction: direction,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(children.length, (int i) {
              return Expanded(child: Center(child: children[i]));
            }),
          ),
        );
      },
    );
  }
}
