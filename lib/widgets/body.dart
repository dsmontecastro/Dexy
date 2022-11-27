import 'package:flutter/material.dart';

import 'package:pokedex/widgets/body/_body.dart';
import 'package:pokedex/api/pokedex.dart';
import 'package:pokedex/api/pokemon.dart';

Body body(
  TextEditingController searchController,
) =>
    Body(searchController: searchController);

class Body extends StatefulWidget {
  const Body({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  // Body of App Proper

  // Constant Properties
  static const alignment = MainAxisAlignment.spaceEvenly;

  // Index State
  int index = 0;

  int getIndex() => index;

  void setIndex(int value) {
    setState(() {
      index = value;
      // print("Body: $index");
    });
  }

  @override
  Widget build(context) {
    // Build Proper

    // Get Pokedex from Initialized Class
    List<Pokemon> pokedex = Pokedex.pokedex
        .where((pokemon) => pokemon.name.startsWith(widget.searchController.text))
        .toList();

    // Core Children
    List<Widget> children = [
      bodyUpper(pokedex[index]),
      bodyLower(pokedex, setIndex, getIndex)
    ];

    return OrientationBuilder(
      builder: (context, orientation) {
        final isVertical = orientation == Orientation.portrait;
        final Axis direction = isVertical ? Axis.vertical : Axis.horizontal;

        return Flex(
          mainAxisAlignment: alignment,
          direction: direction,
          children: List.generate(
            children.length,
            (int i) => Expanded(child: Center(child: children[i])),
          ),
        );
      },
    );
  }
}
