import 'package:pokedex/api/pokemon.dart';

import 'upper.dart';
import 'lower.dart';

Upper bodyUpper(Pokemon pokemon) => Upper(pokemon);

Lower bodyLower(
  List<Pokemon> pokedex,
  Function(int) setter,
  Function getter,
) =>
    Lower(pokedex, setter, getter);
