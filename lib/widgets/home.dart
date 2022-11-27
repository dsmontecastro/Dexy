import 'package:flutter/material.dart';
import 'home/_home.dart';
import 'body.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: drawerKey,
      body: body(searchController),
      drawer: drawer(draw, screenWidth),
      appBar: appBar(draw, searchController),
    );
  }
}
