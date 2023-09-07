import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'body/_body.dart';
import '_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    final scrollBehavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
    );

    return MaterialApp(
      scrollBehavior: scrollBehavior,
      home: Scaffold(
        key: context.key,
        body: const Body(),
        drawer: const NavDrawer(),
        drawerScrimColor: Colors.transparent,
      ),
    );
  }
}
