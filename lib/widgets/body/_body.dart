import 'package:flutter/material.dart';

import 'main_screen/_main_screen.dart';
import 'scroller/_scroller.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool isPortrait = orientation == Orientation.portrait;
        final Axis direction = isPortrait ? Axis.vertical : Axis.horizontal;

        final Size size = MediaQuery.of(context).size;

        final double width = size.width;
        final double height = size.height;
        final double barHeight = isPortrait ? height * 0.075 : height * 0.15;

        return SizedBox(
          width: width,
          height: height,
          child: Flex(
            direction: direction,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: MainScreen(barHeight)),
              Expanded(child: Scroller(barHeight * 0.8)),
            ],
          ),
        );

        //
      },
    );
  }
}
