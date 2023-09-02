import 'package:flutter/material.dart';

import 'body/main_screen.dart';
import 'body/side_screens.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final Size size = MediaQuery.of(context).size;
        final bool isVertical = orientation == Orientation.portrait;
        final Axis direction = isVertical ? Axis.vertical : Axis.horizontal;

        final double barHeight = size.height * 0.15;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Flex(
            direction: direction,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: MainScreen(barHeight)),
              Expanded(child: Pages(barHeight * 0.8)),
              // Expanded(child: SideScreen(barHeight * 0.8)),
            ],
          ),
        );

        //
      },
    );
  }
}
