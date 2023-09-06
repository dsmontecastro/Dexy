import 'package:flutter/material.dart';

import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/widgets/_misc/type_box.dart';

class FormSprite extends StatelessWidget {
  const FormSprite({
    super.key,
    required this.form,
    required this.species,
    required this.toggle,
    required this.shiny,
    required this.multi,
  });

  final Pokemon form;
  final String species;
  final Function() toggle;
  final bool multi;
  final bool shiny;

  static const path = "assets/pokemon";
  static const cursor = SystemMouseCursors.click;

  @override
  Widget build(context) {
    final int id = form.id;
    final String name = form.name.form(species);

    final String folder = shiny ? "shinies" : "sprites";
    final String loc = "$path/$folder";

    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final padH = EdgeInsets.symmetric(horizontal: width * 0.15);

      final types = TypingBoxes(form.type1, form.type2, false);

      final text = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: multi ? Colors.grey.shade800 : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          multi ? name : "",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );

      final image = MouseRegion(
        cursor: cursor,
        child: GestureDetector(
          onTap: toggle,
          child: Image.asset(
            "$loc/$id.png",
            fit: BoxFit.scaleDown,
            gaplessPlayback: true,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stackTrace) {
              if (shiny) {
                return Image.asset("$path/sprites/$id.png");
              } else {
                return Image.asset("$loc/0.png");
              }
            },
          ),
        ),
      );

      return Padding(
        padding: padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Flexible(flex: 2, child: text),
            const Spacer(flex: 1),
            Expanded(flex: 9, child: image),
            const Spacer(flex: 1),
            Flexible(flex: 2, child: types),
            const Spacer(flex: 2),
          ],
        ),
      );

      //
    });
  }
}
