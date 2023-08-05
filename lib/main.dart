import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:provider/provider.dart';
import 'extensions/providers.dart';

import 'prefs/prefs.dart';
import 'widgets/home.dart';
import 'providers/dex.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else {}

  runApp(const Wrapper());
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(context) {
    return MultiProvider(
      providers: Providers.providers,
      builder: (context, child) => const Home(),
    );
  }

  // @override
  // Widget build(context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => Dex(),
  //     builder: (context, child) => const Home(),
  //   );
  // }
}
