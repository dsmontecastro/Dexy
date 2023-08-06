import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/providers/drawers.dart';

extension Providers on BuildContext {
  //

  // List of Providers for MultiProvider
  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<Dex>(create: (_) => Dex()),
    ChangeNotifierProvider<Drawers>(create: (_) => Drawers()),
  ];

  // Shortcuts for Drawers Provider
  GlobalKey<ScaffoldState> get navKey => watch<Drawers>().navKey;
  GlobalKey<ScaffoldState> get sideKey => watch<Drawers>().sideKey;
  void drawSide() => read<Drawers>().drawSide();
  void drawNav() => read<Drawers>().drawNav();

  // Shortcuts for Dex Provider
  Dex get dex => watch<Dex>(); // Mainly for getting DB elements
  Dex get db => read<Dex>(); // Mainly for activating DB Functions

  // TEMP
  static bool _online = true;
  bool get online => _online;
  void toggleNetUse() => _online = !_online;
}
