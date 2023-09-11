import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

class SearchField extends StatelessWidget {
  const SearchField(this.height, this.controller, {super.key});
  final PageController controller;
  final double height;

  static final Color color = Colors.grey.shade800;
  static const Icon icon = Icon(Icons.search, color: Colors.black);

  @override
  Widget build(context) {
    //

    void filter(String text) {
      context.db.filter(text);
      controller.jumpTo(0);
    }

    final padding = EdgeInsets.symmetric(
      horizontal: 25,
      vertical: height * 0.2,
    );

    return Container(
      color: color,
      height: height,
      child: Padding(
        padding: padding,
        child: SearchBar(
          leading: icon,
          onChanged: filter,
          hintText: "Search...",
        ),
      ),
    );
  }
}
