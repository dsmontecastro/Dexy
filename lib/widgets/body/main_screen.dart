import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

import 'package:pokedex/database/models/species.dart';
import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/widgets/body/main_screen/title_bar.dart';

import 'main_screen/data_top.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(context) {
    Species species = context.dex.entry;
    Pokemon form = context.dex.form;

    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;

      final double wOffset = width * 0.35;
      final double hOffset = height * 0.15;

      final Widget data = Column(
        children: [
          Expanded(flex: 6, child: DataTop(form, wOffset)),
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
            padding: EdgeInsets.only(top: hOffset * 0.9),
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(color: Colors.red),
              child: data,
            ),
          ),

          SizedBox(height: hOffset, child: TitleBar(species, wOffset)),

          //
        ],
      );

      //
    });

    //
  }
}
