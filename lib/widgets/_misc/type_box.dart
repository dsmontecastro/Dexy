import 'package:flutter/material.dart';

import 'package:pokedex/types/enums/typing.dart';

class TypingBoxes extends StatelessWidget {
  const TypingBoxes(this.type1, this.type2, this.vertical, {super.key});
  final bool vertical;
  final Typing type1;
  final Typing type2;

  @override
  Widget build(context) {
    final direction = vertical ? Axis.vertical : Axis.horizontal;

    final bool none = type1 == Typing.error;
    final bool solo = type2 == Typing.error;

    final Widget box1 = TypingBox(type1);
    final Widget box2 = TypingBox(type2);

    final boxes = Flex(
      direction: direction,
      children: [
        Flexible(flex: 8, child: box1),
        const Spacer(flex: 1),
        Flexible(flex: 8, child: box2),
      ],
    );

    return none ? Container() : (solo ? box1 : boxes);

    //
  }
}

class TypingBox extends StatelessWidget {
  const TypingBox(this.typing, {super.key});
  final Typing typing;

  static const padding = EdgeInsets.symmetric(horizontal: 10, vertical: 3);

  @override
  Widget build(context) {
    final String name = typing.name.toUpperCase();
    final Color color = typing.boxColor;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );

    //
  }
}
