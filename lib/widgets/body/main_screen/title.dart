import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/database/models/species.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(this.species, this.type1, this.type2, {super.key});
  final Species species;
  final Typing type1;
  final Typing type2;

  @override
  Widget build(context) {
    final name = "#${species.id}-${species.name.capitalize()}";
    final genus = species.genus;

    return Container(
      decoration: const BoxDecoration(color: Colors.amber),

      //
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //

            //
            Flexible(
              child: Container(
                decoration: const BoxDecoration(color: Colors.red),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      //

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //

                          //
                          Text(
                            name,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),

                          //
                          Text(
                            genus,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),

                          //
                        ],
                      ),

                      //
                    ],
                  ),
                ),
              ),
            ),

            //
          ],
        ),
      ),

      //
    );
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
