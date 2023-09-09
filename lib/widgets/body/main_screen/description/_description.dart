import 'package:flutter/material.dart';

import 'package:pokedex/widgets/_misc/clippers.dart';
import 'package:pokedex/database/models/species.dart';

class Description extends StatelessWidget {
  const Description(this.species, {super.key});
  final Species species;

  static const tagStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

  static final innerColor = Colors.grey.shade400;
  static final outerColor = Colors.grey.shade900;

  @override
  Widget build(context) {
    final String entry = species.text;

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;

      return Container(
        color: outerColor,
        constraints: const BoxConstraints.expand(),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //

              ClipPath(
                clipper: SlantRightDown(0.8),
                child: Container(
                  color: innerColor,
                  width: width * 0.15,
                  height: height * 0.15,
                  child: const FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.5,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(" ENTRY   ", style: tagStyle),
                    ),
                  ),
                ),
              ),

              Container(
                color: innerColor,
                width: double.infinity,
                height: height * 0.65,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.75,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    child: SelectableText(entry, maxLines: 3),
                  ),
                ),
              ),

              //
            ],
          ),
        ),
      );

      //
    });
  }
}
