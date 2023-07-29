import 'package:flutter/material.dart';

import 'package:pokedex/extensions/provider.dart';
import 'package:pokedex/database/models/_model.dart';

const Icon back = Icon(Icons.arrow_back);
const Icon load = Icon(Icons.refresh);

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this.draw, this.width, {super.key});
  final Function draw;
  final double width;

  @override
  Widget build(context) {
    return Drawer(
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: back,
            alignment: Alignment.topLeft,
            onPressed: () => draw(),
          ),
          const DrawerMenu(),
          IconButton(
            icon: load,
            alignment: Alignment.bottomLeft,
            onPressed: () async => await context.db.callAPI(table: Models.ability),
          ),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(context) {
    return const Expanded(child: Column());
  }
}
