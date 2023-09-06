import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

import 'main_screen/forms.dart';
import 'main_screen/app_bar.dart';
import 'main_screen/description.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.barHeight, {super.key});
  final double barHeight;

  static const double left = 0.35;

  @override
  Widget build(context) {
    Species species = context.dex.entry;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          //

          Padding(
            padding: EdgeInsets.only(top: barHeight * 0.8),
            child: Column(
              children: [
                Expanded(flex: 7, child: Forms(species)),
                Expanded(flex: 3, child: Description(species)),
              ],
            ),
          ),

          SizedBox(height: barHeight, child: MainAppBar(species, left)),
          //
        ],
      );

      //
    });

    //
  }
}
