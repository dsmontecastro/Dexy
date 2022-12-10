import 'package:flutter/material.dart';
import 'package:pokedex/database/services/pokedex.dart';
// import 'package:pokedex/api/pokedex.dart';
import 'package:pokedex/widgets/home.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/extensions/provider.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    context.pokedex.callAPI();
  }

  @override
  Widget build(context) {
    bool isLoaded = context.pokedex.isLoaded;
    return (isLoaded) ? const AppProper() : const CircularProgressIndicator();
  }
}

class AppProper extends StatelessWidget {
  const AppProper({super.key});

  static const home = Home();
  static const title = "[TEST] Pokedex";

  @override
  Widget build(context) {
    return MaterialApp(
      home: home,
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
