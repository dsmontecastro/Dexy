import 'package:flutter/material.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/database/models/pokemon.dart';

class TypeGradient extends StatelessWidget {
  const TypeGradient(this.type1, this.type2, {super.key});
  // const TypeGradient(this.type1, this.type2, this.left, {super.key});
  final Typing type1;
  final Typing type2;
  // final double left;

  @override
  Widget build(context) {
    final Color color1 = type1.color;
    final Color color2 = (type2 == Typing.error) ? color1 : type2.color;

    return Container(
      // constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        // gradient: RadialGradient(
        //   radius: 1,
        //   center: Alignment.topCenter,
        //   stops: const [0.0, 0.7, 1.0],
        //   colors: [
        //     color1.withOpacity(0.9),
        //     color1.withOpacity(0.7),
        //     color2.withOpacity(0.9),
        //   ],
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
  }
}
