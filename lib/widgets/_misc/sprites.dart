import 'package:flutter/material.dart';

class SpriteHandler {
  // Getter Service for creating Pokemon Sprites, Shinies, and Icons

  // Path Information ----------------------------------------------------------

  static const String _path = "assets/pokemon";
  static const String _icons = "$_path/icons";
  static const String _shinies = "$_path/shinies";
  static const String _sprites = "$_path/sprites";

  // Primary Function ----------------------------------------------------------

  static Image getAsset(String type, int id) {
    return Image.asset(
      "$type/$id.png",
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset("$type/0.png");
      },
    );
  }

  // Specific Functions --------------------------------------------------------

  static Image getIcon(int id) {
    return getAsset(_icons, id);
  }

  static Image getShiny(int id) {
    return getAsset(_shinies, id);
  }

  static Image getSprite(int id) {
    return getAsset(_sprites, id);
  }
}
