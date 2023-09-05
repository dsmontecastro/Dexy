import 'package:flutter/material.dart';

import 'package:pokedex/types/enums/typing.dart';

class TypingBox extends StatelessWidget {
  const TypingBox(this.typing, {super.key});
  final Typing typing;

  @override
  Widget build(context) {
    String name = typing.name;
    Color color = typing.color;

    return Container(
      color: color,
    );
  }
}
