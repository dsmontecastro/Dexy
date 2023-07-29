import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/database/services.dart';

extension DexHandler on BuildContext {
  Dex get dex => watch<Dex>(); // Mainly for getting DB elements
  Dex get db => read<Dex>(); // Mainly for activating DB Functions

  static bool _online = true;
  bool get online => _online;
  void toggleNetUse() => _online = !_online;
}
