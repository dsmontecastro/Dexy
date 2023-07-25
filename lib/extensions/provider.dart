import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/database/services.dart';

extension DexHandler on BuildContext {
  Dex get dex => read<Dex>();
}
