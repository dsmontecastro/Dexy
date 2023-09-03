import 'package:flutter/material.dart';

import '_test.dart'; // TEMP
import 'pages/scroller.dart';

typedef PageMaker = Widget Function(double d);

final List<PageMaker> pageList = [
  (double d) => Scroller(d),
  (double d) => Test(1, d),
  (double d) => Test(2, d),
  (double d) => Test(3, d),
  (double d) => Test(4, d),
];

final pageCount = pageList.length;
