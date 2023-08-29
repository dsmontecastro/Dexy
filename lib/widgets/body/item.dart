import 'package:flutter/material.dart';

import 'item/sprite.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      constraints: const BoxConstraints.expand(),
      alignment: Alignment.center,
      child: const Center(
        child: Column(
          children: [
            Expanded(child: PokemonSprite(300)),
          ],
        ),
      ),
    );
  }
}
