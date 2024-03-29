import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/providers/themes.dart';
// import 'package:pokedex/providers/layout.dart';
import 'package:pokedex/providers/drawers.dart';

extension Providers on BuildContext {
  //

  // List of Providers for MultiProvider
  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<Dex>(create: (_) => Dex()),
    ChangeNotifierProvider<Themes>(create: (_) => Themes()),
    ChangeNotifierProvider<Drawers>(create: (_) => Drawers()),
  ];

  // Shortcuts for Dex Provider
  Dex get dex => watch<Dex>(); // Mainly for getting DB elements
  Dex get db => read<Dex>(); // Mainly for activating DB Functions

  // Shortcuts for Themes Provider

  // Shortcuts for Drawers Provider
  GlobalKey<ScaffoldState> get key => watch<Drawers>().key;
  void drawSide() => read<Drawers>().drawSide();
  void drawNav() => read<Drawers>().drawNav();

  // TEMP
  static bool _online = true;
  bool get online => _online;
  void toggleNetUse() => _online = !_online;
}
