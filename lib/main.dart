import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

import 'prefs/prefs.dart';
import 'widgets/home.dart';
import 'extensions/providers.dart';

const WindowOptions windowOptions = WindowOptions(
  backgroundColor: Colors.transparent,
  minimumSize: Size(400, 600),
  size: Size(800, 600),
  skipTaskbar: false,
  center: true,
  title: "Dex",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Extra configuration for Desktops

    // PC SQFlite
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Windows Manager
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );

    //
  }

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
}
