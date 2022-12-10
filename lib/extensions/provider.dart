import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/database/services/pokedex.dart';

extension Dexy on BuildContext {
  Pokedex get pokedex => read<Pokedex>();
}
