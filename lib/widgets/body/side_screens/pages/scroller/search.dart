import 'package:flutter/material.dart';
import 'package:pokedex/extensions/providers.dart';

class SearchField extends StatelessWidget {
  const SearchField(this.height, {super.key});
  final double height;

  static const searchIcon = Icon(Icons.search, color: Colors.black);
  static const searchPad = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static final searchDecor = BoxDecoration(color: Colors.grey.shade800);

  @override
  Widget build(context) {
    return Container(
      decoration: searchDecor,
      height: height,
      child: Padding(
        padding: searchPad,
        child: SearchBar(
          leading: searchIcon,
          hintText: "Search...",
          onChanged: context.db.filter,
        ),
      ),
    );
  }
}
