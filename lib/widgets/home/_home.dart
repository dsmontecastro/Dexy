import 'package:flutter/material.dart';

import 'appbar.dart';
import 'drawer.dart';

AppBar appBar(
  Function draw,
  TextEditingController searchController,
) =>
    homeAppBar(draw, searchController);
Drawer drawer(Function draw, double width) => homeDrawer(draw, width);
