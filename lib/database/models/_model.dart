import 'ability.dart';
import 'damage_class.dart';
import 'evolution.dart';
import 'generation.dart';
import 'typing.dart';
import 'move.dart';
import 'pokemon.dart';
import 'species.dart';
import 'target.dart';

class Models {
  const Models();

  // Get Model Names
  static const String ability = abilityModel;
  static const String dmgClass = damageClassModel;
  static const String evolution = evolutionModel;
  static const String generation = generationModel;
  static const String move = moveModel;
  static const String typing = typingModel;
  static const String pokemon = pokemonModel;
  static const String species = speciesModel;
  static const String target = targetModel;

  // Create Model Variant from API
  static T? fromAPI<T>(Map<String, dynamic> json) {
    if (T == Ability) {
      return Ability.fromAPI(json) as T;
    } else if (T == DamageClass) {
      return DamageClass.fromAPI(json) as T;
    } else if (T == Evolution) {
      return Evolution.fromAPI(json) as T;
    } else if (T == Generation) {
      return Generation.fromAPI(json) as T;
    } else if (T == Move) {
      return Move.fromAPI(json) as T;
    } else if (T == Typing) {
      return Typing.fromAPI(json) as T;
    } else if (T == Pokemon) {
      return Pokemon.fromAPI(json) as T;
    } else if (T == Species) {
      return Species.fromAPI(json) as T;
    } else if (T == Target) {
      return Target.fromAPI(json) as T;
    } else {
      return null;
    }
  }

  // Create Model Variant from DB
  static T? fromDB<T>(Map<String, dynamic> json) {
    if (T == Ability) {
      return Ability.fromDB(json) as T;
    } else if (T == DamageClass) {
      return DamageClass.fromDB(json) as T;
    } else if (T == Evolution) {
      return Evolution.fromDB(json) as T;
    } else if (T == Generation) {
      return Generation.fromDB(json) as T;
    } else if (T == Move) {
      return Move.fromDB(json) as T;
    } else if (T == Typing) {
      return Typing.fromDB(json) as T;
    } else if (T == Pokemon) {
      return Pokemon.fromDB(json) as T;
    } else if (T == Species) {
      return Species.fromDB(json) as T;
    } else if (T == Target) {
      return Target.fromDB(json) as T;
    } else {
      return null;
    }
  }

  // Get Table-creation Commands
  static const List<String> makers = [
    abilityMaker,
    damageClassMaker,
    evolutionMaker,
    generationMaker,
    moveMaker,
    typingMaker,
    pokemonMaker,
    speciesMaker,
    targetMaker
  ];

  static const Map<Type, List<String>> fields = {
    Ability: AbilityFields.fields,
    DamageClass: DamageClassFields.fields,
    Evolution: EvolutionFields.fields,
    Generation: GenerationFields.fields,
    Move: MoveFields.fields,
    Typing: TypingFields.fields,
    Pokemon: PokemonFields.fields,
    Species: SpeciesFields.fields,
    Target: TargetFields.fields,
  };

  static const Map<String, Type> models = {
    abilityModel: Ability,
    damageClassModel: DamageClass,
    evolutionModel: Evolution,
    generationModel: Generation,
    moveModel: Move,
    typingModel: Typing,
    pokemonModel: Pokemon,
    speciesModel: Species,
    targetModel: Target,
  };
}

abstract class Model {
  Model();

  // JSON Parsers
  int getId() => -1;
  Map<String, dynamic> toDB();
}
