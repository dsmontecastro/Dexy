import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import '_body.dart';
import '_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        key: context.key,
        body: const Body(),
        drawer: const NavDrawer(),
        drawerScrimColor: Colors.transparent,
      ),
    );
  }
}
