import 'package:flutter/material.dart';

import '_test.dart'; // TEMP

typedef PageMaker = Widget Function(double bar, double padH, double padV);

final List<PageMaker> pageList = [
  (b, h, v) => Test(1, b),
  (b, h, v) => Test(2, b),
  (b, h, v) => Test(3, b),
  (b, h, v) => Test(4, b),
];

final pageCount = pageList.length;

class PageWrapper extends StatelessWidget {
  const PageWrapper(this.padH, this.padV, this.page, {super.key});
  final double padH;
  final double padV;
  final Widget page;

  @override
  Widget build(context) {
    return FractionallySizedBox(
      widthFactor: 1 - (padH * 2),
      heightFactor: 1 - (padV * 2),
      child: page,
    );
  }
}
