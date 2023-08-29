import 'package:flutter/material.dart';

class Sprites {
  //

  static const String _sprite = "assets/sprites/_sprite.png";

  static Image getSprite(String? url, double side) {
    if (url == null) {
      return Image.asset(_sprite, width: side, height: side);
    } else {
      return Image.network(url, width: side, height: side);
    }
  }

  // static Image getSprite(String? url, {bool online = true}) {
  //   if (!online || url == null) return _sprite;
  //   return Image.network(url);
  // }
}
