import 'package:flutter/material.dart';

import 'item/item.dart';
import 'side/side.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // static const _children = [Item(), Side()];
  static const _children = [Item(), Text("TEMP")];

  @override
  Widget build(context) {
    return MaterialApp(
      home: OrientationBuilder(
        builder: (context, orientation) {
          final bool flag = orientation == Orientation.portrait;
          final Axis direction = flag ? Axis.vertical : Axis.horizontal;

          return Flex(
              direction: direction,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                _children.length,
                (i) => Expanded(child: _children[i]),
              ));
        },
      ),
    );
  }
}
