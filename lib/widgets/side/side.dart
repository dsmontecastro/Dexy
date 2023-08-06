import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/widgets/_logo.dart';

class Side extends StatelessWidget {
  const Side({super.key});

  static const Icon _search = Icon(Icons.search, color: Colors.black);

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    final double gap = size.height * 0.1;

    Widget? _endDrawer = SafeArea(
      minimum: EdgeInsets.only(top: gap + 1),
      child: const Center(child: Text("SIDE MENU")),
    );

    // Widget? _modal =

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          //

          // App Proper
          body: const Center(child: Text("TEMP")),

          // Drawer Elements
          key: context.sideKey,
          drawerScrimColor: Colors.transparent,

          // Changes based on Orientation
          endDrawer: SafeArea(
            minimum: EdgeInsets.only(top: gap + 1),
            child: const Center(child: Text("SIDE MENU")),
          ),

          // Custom AppBar
          appBar: AppBar(
            elevation: 10.0,
            toolbarHeight: gap,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            actions: [Container()],

            // Title: Search Widget
            centerTitle: true,
            titleSpacing: 5.0,
            title: SearchBar(
              leading: _search,
              hintText: "Search...",
              onChanged: context.db.filter,
              constraints: BoxConstraints(
                maxHeight: gap * 0.7,
                minHeight: gap * 0.7,
              ),
            ),
          ),
        );
      },
    );
  }
}
