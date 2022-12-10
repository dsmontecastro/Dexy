import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/prefs/prefs.dart';
import 'package:pokedex/widgets/loader.dart';

// import 'package:pokedex/api/pokedex.dart';
import 'database/services/pokedex.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  // await Pokedex.init();

  runApp(const WrappedApp());
}

class WrappedApp extends StatelessWidget {
  const WrappedApp({super.key});

  @override
  Widget build(context) {
    return ChangeNotifierProvider(
      create: (context) => Pokedex(),
      builder: (context, child) => const Loader(),
    );
  }
}
