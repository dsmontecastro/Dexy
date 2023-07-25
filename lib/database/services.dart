import 'package:flutter/material.dart';

import 'db.dart';
import 'api.dart';

// Models
import 'models/ability.dart';
import 'models/damage_class.dart';
import 'models/evolution.dart';
import 'models/generation.dart';
import 'models/move.dart';
import 'models/typing.dart';
import 'models/pokemon.dart';
import 'models/species.dart';
import 'models/target.dart';

class Dex with ChangeNotifier {
  //

  static const int _items = 10;
  final Pokemon fill = Pokemon.fill();

  // Modifiers
  int _listIndex = 0;
  int _itemIndex = 0;
  int get items => _items;
  int get listIndex => _listIndex;
  int get itemIndex => _itemIndex;
  Pokemon? _item;
  Pokemon? get item => _item;
  // List<Pokemon> _pokedex = [];
  List<Pokemon> _pokedex = List.filled(15, Pokemon.fill());
  List<Pokemon> get pokedex => _pokedex;

  // Resources
  List<Ability> _abilities = [];
  List<DamageClass> _dmgClasses = [];
  List<Evolution> _evolutions = [];
  List<Generation> _generations = [];
  List<Pokemon> _pokemon = [];
  List<Species> _species = [];
  List<Move> _moves = [];
  List<Target> _targets = [];
  List<Typing> _typings = [];

  List<Ability> get abilities => _abilities;
  List<DamageClass> get dmgClasses => _dmgClasses;
  List<Evolution> get evolutions => _evolutions;
  List<Generation> get generations => _generations;
  List<Move> get moves => _moves;
  List<Pokemon> get pokemon => _pokemon;
  List<Species> get species => _species;
  List<Target> get targets => _targets;
  List<Typing> get typings => _typings;

  // API Status
  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<bool> callAPI({String table = ""}) async {
    bool success = true;

    if (!_loaded) {
      bool flag = false;

      if (table == "") {
        flag = await DB.instance.updateAll();
      } else {
        flag = await DB.instance.updateModel(table);
      }

      if (flag) {
        _loaded = true;
        success = await fillResources();
        success = await fillPokedex();
      }
    }

    return success;
  }

  // Initialize Fields
  Future<bool> fillPokedex() async {
    bool result = true;

    try {
      _itemIndex = 0;
      _pokedex = _pokemon;
      notifyListeners();
    } catch (err) {
      result = false;
    }

    return result;
  }

  Future<bool> fillResources() async {
    bool result = true;

    try {
      _abilities = await DB.instance.getAll(abilityModel) as List<Ability>;
      _dmgClasses =
          await DB.instance.getAll(damageClassModel) as List<DamageClass>;
      _evolutions = await DB.instance.getAll(evolutionModel) as List<Evolution>;
      _generations =
          await DB.instance.getAll(generationModel) as List<Generation>;
      _moves = await DB.instance.getAll(moveModel) as List<Move>;
      _pokemon = await DB.instance.getAll(pokemonModel) as List<Pokemon>;
      _species = await DB.instance.getAll(speciesModel) as List<Species>;
      _targets = await DB.instance.getAll(targetModel) as List<Target>;
      _typings = await DB.instance.getAll(typingModel) as List<Typing>;
      notifyListeners();
    } catch (err) {
      result = false;
    }

    return result;
  }

  // Change Current Items & Lists
  int count() => _pokedex.length;
  Pokemon? get(int index) {
    Pokemon? item;
    if (index >= 0 && index < _pokedex.length) {
      item = _pokedex[index];
    }
    return item;
  }

  void cycleList(int index) async {
    int max = count();
    _listIndex = index;

    if (listIndex < 0) {
      _listIndex = 0;
    } else if (listIndex >= max) {
      _listIndex = max - 1;
    }

    _item = _pokedex[_listIndex + itemIndex];
    notifyListeners();
  }

  void cycleIndex(int index) async {
    _itemIndex = index;

    if (itemIndex < 0) {
      _itemIndex = 0;
    } else if (itemIndex >= items) {
      _itemIndex = items - 1;
    }

    _item = _pokedex[_itemIndex];
    notifyListeners();
  }

  List<Pokemon> filter(String filter) {
    _pokedex = _pokemon.where((p) => p.name.startsWith(filter)).toList();
    cycleList(0);
    return _pokedex;
  }

  // User-Toggled States
  Future<bool> favorite(Pokemon pokemon) async {
    try {
      await DB.instance.toggleFavorite(pokemon);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> caught(Pokemon pokemon) async {
    try {
      await DB.instance.toggleCaught(pokemon);
      return true;
    } catch (err) {
      return false;
    }
  }

  // [TEMP] Debugging ----------------------------------------------------------

  Future<void> drop(String table) => DB.instance.dropTable(table);
}
