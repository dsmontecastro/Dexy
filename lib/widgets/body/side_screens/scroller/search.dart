import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

class SearchField extends StatelessWidget {
  const SearchField(this.height, {super.key});
  final double height;

  static final Color color = Colors.grey.shade800;
  static const Icon icon = Icon(Icons.search, color: Colors.black);

  @override
  Widget build(context) {
    final padding = EdgeInsets.symmetric(horizontal: 25, vertical: height * 0.2);
    return Container(
      color: color,
      height: height,
      child: Padding(
        padding: padding,
        child: SearchBar(
          leading: icon,
          hintText: "Search...",
          onChanged: context.db.filter,
        ),
      ),
    );
  }
}
