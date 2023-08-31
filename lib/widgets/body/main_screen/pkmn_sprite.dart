import 'package:flutter/material.dart';

import 'package:pokedex/widgets/_misc/sprites.dart';

class PKMNSprite extends StatefulWidget {
  const PKMNSprite(this.id, {super.key});
  final int id;

  @override
  createState() => PKMNSpriteState();
}

class PKMNSpriteState extends State<PKMNSprite> {
  static const Icon icon = Icon(Icons.abc);

  bool isShiny = false;
  void toggleShiny() => setState(() => isShiny = !isShiny);

  @override
  Widget build(context) {
    int id = widget.id;
    Image shiny = SpriteHandler.getShiny(id);
    Image sprite = SpriteHandler.getSprite(id);

    final image = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(id.toString()),
        IconButton(icon: icon, onPressed: toggleShiny),
        Expanded(child: isShiny ? shiny : sprite),
      ],
    );

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(id.toString()),
          IconButton(icon: icon, onPressed: toggleShiny),
          Expanded(child: isShiny ? shiny : sprite),
        ],
      ),
    );
  }
}
