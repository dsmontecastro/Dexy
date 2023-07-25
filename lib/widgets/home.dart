import 'package:flutter/material.dart';

import 'body.dart';
import 'home/appbar.dart';
import 'home/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();

  void draw() {
    setState(() {
      ScaffoldState? key = drawerKey.currentState;
      if (key != null) {
        if (key.isDrawerOpen) {
          key.closeDrawer();
        } else {
          key.openDrawer();
        }
      }
    });
  }

  @override
  Widget build(context) {
    final double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        key: drawerKey,
        body: const Body(),
        appBar: appBar(draw),
        drawer: CustomDrawer(draw, width),
      ),
    );
  }
}
