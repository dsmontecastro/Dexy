import 'package:flutter/material.dart';
// import 'package:pokedex/types/enums/typing.dart';

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

    //
  }
}

// class TypingBox extends StatelessWidget {
//   const TypingBox(this.typing, {super.key});
//   final Typing typing;

//   @override
//   Widget build(context) {
//     String name = typing.name;
//     Color color = typing.color;

//     return Container();
//   }
// }
