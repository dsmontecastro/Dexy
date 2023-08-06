import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'body.dart';
import '_misc/logo.dart';
import 'home/nav_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const Icon _search = Icon(Icons.search, color: Colors.black);

  static const double minGap = 60;

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    final double gap = size.height * 0.1;

    final double appbarHeight = (gap < minGap) ? minGap : gap;

    return MaterialApp(
      home: Scaffold(
        body: const Body(),

        // Drawer Elements
        key: context.key,
        drawerScrimColor: Colors.transparent,

        drawer: SafeArea(
          minimum: EdgeInsets.only(top: appbarHeight + 1),
          child: NavDrawer(size.width / 3),
        ),

        endDrawer: SafeArea(
          minimum: EdgeInsets.only(top: appbarHeight + 1),
          child: const Center(child: Text("SIDE MENU")),
        ),

        // AppBar Design
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appbarHeight),
          child: AppBar(
            elevation: 10.0,
            toolbarHeight: appbarHeight,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,

            actions: [Container()], // Removes trailing icons

            // Title: Search Widget
            centerTitle: true,
            titleSpacing: 5.0,
            title: SearchBar(
              leading: _search,
              hintText: "Search...",
              onChanged: context.db.filter,
              constraints: BoxConstraints(
                maxHeight: appbarHeight * 0.7,
                minHeight: appbarHeight * 0.7,
              ),
            ),

            // Lead: Logo / Drawer Button
            leading: IconButton(
              icon: logo,
              onPressed: context.drawNav,
            ),
          ),
        ),
      ),
    );
  }
}
