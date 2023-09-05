import 'package:flutter/material.dart';

import 'package:pokedex/database/models/species.dart';

import 'data_top/forms.dart';

class DataTop extends StatelessWidget {
  const DataTop(this.species, this.left, {super.key});
  final Species species;
  final double left;

  static const bgColor = Color.fromARGB(255, 177, 177, 177);
  static final bg = Positioned.fill(
    child: Image.asset(
      'assets/images/hex.png',
      repeat: ImageRepeat.repeat,
      color: bgColor,
    ),
  );

  @override
  Widget build(context) {
    return Stack(
      children: [
        bg,
        Row(
          children: [
            // Data(),
            Expanded(flex: 55, child: Container(color: Colors.white.withOpacity(0.5))),
            Expanded(flex: 45, child: Forms(species)),
            // Forms(),
          ],
        )
      ],
    );
  }
}
