import 'package:flutter/material.dart';

class Sprites {
  //

  static final Image _sprite = Image.asset("assets/sprites/_sprite.png");

  static Image getSprite(String? url, {bool online = true}) {
    if (!online || url == null) return _sprite;
    return Image.network(url);
  }
}
