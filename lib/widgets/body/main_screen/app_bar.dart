import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/database/models/species.dart';

import 'app_bar/info.dart';
import 'app_bar/order.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar(this.species, this.wOffset, {super.key});
  final Species species;
  final double wOffset;

  @override
  Widget build(context) {
    final name = species.name.capitalize();
    final order = species.order.toString();
    final genus = species.genus;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;

      return Stack(
        children: [
          //

          Container(
            height: height * 0.8,
            decoration: BoxDecoration(color: Colors.grey.shade800),
          ),

          SizedBox(
            height: height * 0.9,
            child: OrderBanner(width, Colors.grey.shade900),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: wOffset, child: TitleOrder(order)),
              SizedBox(width: width * 0.04),
              Expanded(child: TitleInfo(name, genus)),
              SizedBox(width: width * 0.1),
            ],
          ),

          //
        ],
      );

      //
    });
  }
}
