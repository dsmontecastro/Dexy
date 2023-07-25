import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'prefs/prefs.dart';
import 'widgets/home.dart';
import 'database/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const Wrapper());
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(context) {
    return ChangeNotifierProvider(
      create: (context) => Dex(),
      builder: (context, child) => const Home(),
    );
  }
}
