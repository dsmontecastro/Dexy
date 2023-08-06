import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
// import 'package:pokedex/database/models/_model.dart';

const Icon back = Icon(Icons.arrow_back);
const Icon load = Icon(Icons.refresh);

class NavDrawer extends StatelessWidget {
  const NavDrawer(this.width, {super.key});
  final double width;

  @override
  Widget build(context) {
    return Drawer(
      width: width,
      shadowColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: back,
            alignment: Alignment.topLeft,
            onPressed: context.drawNav,
          ),
          const NavMenu(),
          IconButton(
            icon: load,
            alignment: Alignment.bottomLeft,
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(context) {
    return const Expanded(child: Column());
  }
}
