import 'package:flutter/material.dart';

import 'scroller/body.dart';
import 'scroller/search.dart';

class Scroller extends StatelessWidget {
  const Scroller(this.barHeight, {super.key});
  final double barHeight;

  @override
  Widget build(context) {
    return Column(
      children: [
        SearchField(barHeight),
        const Expanded(child: ScrollerBody()),
      ],
    );
  }
}
