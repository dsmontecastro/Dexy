import 'package:flutter/material.dart';
import 'package:pokedex/api/pokedex.dart';
import 'package:pokedex/prefs/prefs.dart';
import 'package:pokedex/widgets/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Pokedex.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static const home = Home();
  static const title = "[TEST] Pokedex";

  @override
  Widget build(context) {
    return MaterialApp(
      home: home,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
