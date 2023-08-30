import 'package:flutter/material.dart';

import 'item/pkmn_sprite.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      constraints: const BoxConstraints.expand(),
      alignment: Alignment.center,
      child: const Center(
        child: Column(
          children: [
            Expanded(child: PKMNSprite(300)),
          ],
        ),
      ),
    );
  }
}
