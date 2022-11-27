import 'package:pokedex/prefs/prefs.dart';

class Favorites {
  // Global Favorites Class

  // Constants
  static const int tryLimit = 1000;
  static const String prefKey = "favorites";

  // Variables
  static late final List<String> _favorites;
  static List<String> get favorites => _favorites;

  // Constructor
  static List<String> init() {
    List<String>? favorites = SharedPrefs.getStringList(prefKey);
    if (favorites != null) {
      _favorites = favorites;
    } else {
      _favorites = [];
    }
    return _favorites;
  }

  // Update Functions
  static void insert(String name) => _favorites.add(name);

  static void remove(int index) => _favorites.removeAt(index);
}
