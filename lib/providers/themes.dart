import 'package:flutter/material.dart';

import 'package:pokedex/prefs/prefs.dart';

enum ColorType { primary, background }

final List<String> themeElements = [
  "primaryColor",
  "backgroundColor",
];

class Themes extends ChangeNotifier {
  // Theme Notifier Class for Provider

  Themes() {
    for (String element in themeElements) {
      _colors[element] = Color(SharedPrefs.getInt(element) ?? Defaults.primaryColor);
    }
    _liteTheme = buildTheme(ThemeMode.light);
    _darkTheme = buildTheme(ThemeMode.dark);
  }

  // Constants -----------------------------------------------------------------

  static const double topHeight1 = 0.9;
  static const double topHeight2 = topHeight1 * 0.9;

  // Mode Handling -------------------------------------------------------------

  ThemeMode _mode = ThemeMode.system;
  ThemeData _darkTheme = Defaults.darkTheme;
  ThemeData _liteTheme = Defaults.liteTheme;

  ThemeMode get mode => _mode;
  ThemeData get darkTheme => buildTheme(ThemeMode.dark);
  ThemeData get liteTheme => buildTheme(ThemeMode.light);

  ThemeData get baseTheme => (_mode == ThemeMode.dark) ? _darkTheme : _liteTheme;
  ThemeData get currTheme => (_mode == ThemeMode.dark) ? darkTheme : liteTheme;

  void toggleMode() => (_mode == ThemeMode.dark) ? setMode(ThemeMode.light) : setMode(ThemeMode.dark);

  void setMode(ThemeMode mode) {
    _mode = (mode);
    notifyListeners();
  }

  // Theme Personalization
  final Map<String, Color> _colors = {};
  Color? colors(String key) => _colors[key];

  void updateTheme() {
    ThemeData base = (_mode == ThemeMode.dark) ? _darkTheme : _liteTheme;
    base = base.copyWith(
      primaryColor: _colors["primaryColor"],
      backgroundColor: _colors["backgroundColor"],
    );
    notifyListeners();
  }

  ThemeData buildTheme(ThemeMode mode) {
    ThemeData base = (mode == ThemeMode.dark) ? _darkTheme : _liteTheme;
    ThemeData theme = base.copyWith(
      primaryColor: _colors["primaryColor"],
      backgroundColor: _colors["backgroundColor"],
    );
    return theme;
  }
}

// Default Values for App Start or Reset
class Defaults {
  static const bool darkMode = false;
  static const ThemeMode mode = ThemeMode.light;

  // Default Colors
  static final int primaryColor = const Color.fromARGB(255, 25, 175, 255).value;
  static final int backgroundColor = Colors.grey.value;

  // Final Light Theme elements
  static final ThemeData liteTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.grey,
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey.shade600,
    ),
    drawerTheme: const DrawerThemeData(width: 300.0, backgroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.grey.shade900,
      selectedLabelStyle: TextStyle(color: Colors.grey.shade800),
      selectedIconTheme: IconThemeData(color: Colors.grey.shade800, size: 35),
      unselectedItemColor: Colors.grey.shade300,
      unselectedLabelStyle: TextStyle(color: Colors.grey.shade300),
      unselectedIconTheme: IconThemeData(color: Colors.grey.shade300, size: 35),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 20.0,
      ),
      bodyLarge: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 15.0,
      ),
    ),
  );

  // Final Dark Theme elements
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    // textTheme: TextTheme(
    //   titleLarge: const TextStyle(
    //     color: Colors.white,
    //     fontSize: 20.0,
    //   ),
    //   subtitle1: const TextStyle(
    //     color: Colors.white70,
    //     fontSize: 18.0,
    //   ),
    // ),
  );
}
