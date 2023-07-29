import 'evolution.dart';
import 'ability.dart';
import 'pokemon.dart';
import 'species.dart';
import 'item.dart';
import 'move.dart';

class Models {
  // // Get Model Names
  static const String ability = abilityModel;
  static const String evolution = evolutionModel;
  static const String item = itemModel;
  static const String move = moveModel;
  static const String pokemon = pokemonModel;
  static const String species = speciesModel;

  // Create Model Variant from API
  static T fromAPI<T>(Map<String, dynamic> json) {
    if (T == Ability) {
      return Ability.fromAPI(json) as T;
    } else if (T == Evolution) {
      return Evolution.fromAPI(json) as T;
    } else if (T == Item) {
      return Item.fromAPI(json) as T;
    } else if (T == Move) {
      return Move.fromAPI(json) as T;
    } else if (T == Pokemon) {
      return Pokemon.fromAPI(json) as T;
    } else if (T == Species) {
      return Species.fromAPI(json) as T;
    } else {
      return Pokemon.fromAPI(json) as T;
    }
  }

  // Create Model Variant from DB
  static T fromDB<T>(Map<String, dynamic> json) {
    if (T == Ability) {
      return Ability.fromDB(json) as T;
    } else if (T == Evolution) {
      return Evolution.fromDB(json) as T;
    } else if (T == Item) {
      return Item.fromDB(json) as T;
    } else if (T == Move) {
      return Move.fromDB(json) as T;
    } else if (T == Pokemon) {
      return Pokemon.fromDB(json) as T;
    } else if (T == Species) {
      return Species.fromDB(json) as T;
    } else {
      return Models.fromDB(json) as T;
    }
  }

  // Create Filler for Model
  static T filler<T>() {
    if (T == Ability) {
      return Ability.filler() as T;
    } else if (T == Evolution) {
      return Evolution.filler() as T;
    } else if (T == Item) {
      return Item.filler() as T;
    } else if (T == Move) {
      return Move.filler() as T;
    } else if (T == Pokemon) {
      return Pokemon.filler() as T;
    } else if (T == Species) {
      return Species.filler() as T;
    } else {
      return Pokemon.filler() as T;
    }
  }

  // Get Table-creation Commands
  static const Map<String, String> makers = {
    evolutionModel: evolutionMaker,
    abilityModel: abilityMaker,
    itemModel: itemMaker,
    moveModel: moveMaker,
    pokemonModel: pokemonMaker,
    speciesModel: speciesMaker,
  };

  static Map<String, Map<String, dynamic>> fillers = {
    evolutionModel: Evolution.filler().toDB(),
    abilityModel: Ability.filler().toDB(),
    itemModel: Item.filler().toDB(),
    moveModel: Move.filler().toDB(),
    pokemonModel: Pokemon.filler().toDB(),
    speciesModel: Species.filler().toDB(),
  };

  static const Map<Type, List<String>> fields = {
    Ability: AbilityFields.fields,
    Evolution: EvolutionFields.fields,
    Item: ItemFields.fields,
    Move: MoveFields.fields,
    Pokemon: PokemonFields.fields,
    Species: SpeciesFields.fields,
  };

  // Reordered for Foreign Keys
  static const Map<String, Type> models = {
    evolutionModel: Evolution,
    abilityModel: Ability,
    itemModel: Item,
    moveModel: Move,
    pokemonModel: Pokemon,
    speciesModel: Species,
  };
}

abstract class Model {
  Model();

  // JSON Parsers
  int getId() => -1;
  Map<String, dynamic> toDB();
}
