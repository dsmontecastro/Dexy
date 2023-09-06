import 'package:flutter/material.dart';

import 'package:pokedex/types/enums/typing.dart';

class TypeGradient extends StatelessWidget {
  const TypeGradient(this.type1, this.type2, {super.key});
  final Typing type1;
  final Typing type2;

  static const duration = Duration(milliseconds: 250);

  @override
  Widget build(context) {
    final Color color1 = type1.bgColor;
    final Color color2 = (type2 == Typing.error) ? color1 : type2.bgColor;

    final gradient = AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.4, 0.6, 1.0],
          colors: [
            color1.withOpacity(0.9),
            color1.withOpacity(0.7),
            color2.withOpacity(0.7),
            color2.withOpacity(0.9),
          ],
        ),
      ),
    );

    return (type1 == Typing.error) ? Container() : gradient;
  }
}
