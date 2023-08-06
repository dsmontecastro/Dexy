import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'body.dart';
import 'misc/logo.dart';
import 'home/nav_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const Icon _search = Icon(Icons.search, color: Colors.black);

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    final double gap = size.height * 0.1;

    return MaterialApp(
      home: Scaffold(
        //

        // App Proper
        body: const Body(),

        // Drawer Elements
        key: context.key,
        drawerScrimColor: Colors.transparent,

        drawer: SafeArea(
          minimum: EdgeInsets.only(top: gap + 1),
          child: NavDrawer(size.width / 3),
        ),

        endDrawer: SafeArea(
          minimum: EdgeInsets.only(top: gap + 1),
          child: const Center(child: Text("SIDE MENU")),
        ),

        // AppBar Design
        appBar: AppBar(
          elevation: 10.0,
          toolbarHeight: gap,
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
              maxHeight: gap * 0.7,
              minHeight: gap * 0.7,
            ),
          ),

          // Lead: Logo / Drawer Button
          leading: IconButton(
            icon: logo,
            onPressed: context.drawNav,
          ),
        ),
      ),
    );
  }
}
