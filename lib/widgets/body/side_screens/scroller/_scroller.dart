import 'package:flutter/material.dart';

import 'body.dart';
import 'search.dart';

class Scroller extends StatelessWidget {
  const Scroller(this.bar, {super.key});
  final double bar;

  @override
  Widget build(context) {
    return Column(
      children: [
        SearchField(bar),
        const Expanded(child: ScrollerBody()),
      ],
    );
  }
}
