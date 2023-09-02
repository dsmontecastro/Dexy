import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/database/models/species.dart';
import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/widgets/body/main_screen/title_bar.dart';

import 'main_screen/data_top.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.barHeight, {super.key});
  final double barHeight;

  @override
  Widget build(context) {
    Species species = context.dex.entry;
    Pokemon form = context.dex.form;

    return LayoutBuilder(builder: (context, constraints) {
      final double leftOffset = constraints.maxWidth * 0.35;

      final Widget data = Column(
        children: [
          Expanded(flex: 6, child: DataTop(form, leftOffset)),
          const Expanded(
            flex: 3,
            child: Text("BOT"),
          ),

          //
        ],
      );

      return Stack(
        children: [
          //

          Padding(
            padding: EdgeInsets.only(top: barHeight * 0.8),
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(color: Colors.red),
              child: data,
            ),
          ),

          SizedBox(height: barHeight, child: TitleBar(species, leftOffset)),
//
          //
        ],
      );

      //
    });

    //
  }
}
