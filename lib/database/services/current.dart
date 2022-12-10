import 'package:flutter/material.dart';

import '../db.dart';

// Models
import '../models/ability.dart';
import '../models/damage_class.dart';
import '../models/evolution.dart';
import '../models/generation.dart';
import '../models/move.dart';
import '../models/pkmn_type.dart';
import '../models/pokemon.dart';
import '../models/species.dart';
import '../models/target.dart';

class Current with ChangeNotifier {
  //

  late Ability _ability;
  late DamageClass _dmgClass;
  late Evolution _evolution;
  late Generation _generation;
  late Move _move;
  late PkmnType _type;
  late Pokemon _pokemon;
  late Species _species;
  late Target _target;

  // Getters
  Ability get ability => _ability;
  DamageClass get dmgClass => _dmgClass;
  Evolution get evolution => _evolution;
  Generation get generation => _generation;
  Move get move => _move;
  PkmnType get type => _type;
  Pokemon get pokemon => _pokemon;
  Species get species => _species;
  Target get target => _target;

  // // Setters
  // set ability();
  // set dmgClass;
  // set evolution;
  // set generation;
  // set move;
  // set type;
  // set pokemon;
  // set species;
  // set target;

  bool _isBusy = false;
  bool _exists = false;

  set exists(bool value) {
    _exists = value;
    notifyListeners();
  }

  Future<String> getItemById(String tableName, int id) async {
    String result = "Success!";

    try {
      dynamic item = await DB.instance.getById(tableName, id);
      notifyListeners();
    } catch (err) {
      result = err.toString();
    }

    return result;
  }
}
