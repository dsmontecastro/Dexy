import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/database/models/species.dart';

import 'title_bar/info.dart';
import 'title_bar/order.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(this.species, this.wOffset, {super.key});
  final Species species;
  final double wOffset;

  @override
  Widget build(context) {
    final name = species.name.capitalize();
    final order = species.order.toString();
    final genus = species.genus;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight * 0.9;

      return Stack(
        children: [
          Container(height: height, color: Colors.grey.shade900),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: wOffset, child: TitleOrder(order)),
              SizedBox(width: width * 0.04),
              Expanded(
                child: SizedBox(
                  height: height,
                  child: TitleInfo(name, genus),
                ),
              ),
            ],
          ),
        ],
      );

      //
    });
  }
}

class TypingBox extends StatelessWidget {
  const TypingBox(this.typing, {super.key});
  final Typing typing;

  @override
  Widget build(context) {
    String name = typing.name;
    Color color = typing.color;

    return Container();
  }
}
