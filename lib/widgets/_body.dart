import 'package:flutter/material.dart';

import 'body/main_screen.dart';
import 'body/side_screens.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool isVertical = orientation == Orientation.portrait;
        final Axis direction = isVertical ? Axis.vertical : Axis.horizontal;

        final Size size = MediaQuery.of(context).size;

        final double width = size.width;
        final double height = size.height;
        final double barHeight = height * 0.15;

        return SizedBox(
          width: width,
          height: height,
          child: Flex(
            direction: direction,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: MainScreen(barHeight)),
              Expanded(child: SideScreens(barHeight * 0.8)),
            ],
          ),
        );

        //
      },
    );
  }
}