import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pokedex/extensions/provider.dart';

const String logoPath = "assets/images/logo.svg";

AppBar appBar(Function draw) {
  return AppBar(
    // Title: Search Bar
    title: const SearchBar(),
    titleSpacing: 5.0,

    // Lead: App Icon
    leading: IconButton(
      icon: SvgPicture.asset(
        logoPath,
        fit: BoxFit.fitHeight,
      ),
      onPressed: () => draw(),
    ),
  );
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  static final Color fillColor = Colors.grey.shade600;
  static final Color textColor = Colors.red.shade600;

  static Icon prefixIcon = Icon(
    Icons.search,
    color: textColor,
  );

  @override
  Widget build(context) {
    return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: SearchField(),
        ));
  }
}

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController controller = TextEditingController();

  static final Color fillColor = Colors.grey.shade600;
  static final Color textColor = Colors.red.shade600;

  static final Icon prefixIcon = Icon(
    Icons.search,
    color: textColor,
  );

  static final InputDecoration decor = InputDecoration(
    filled: true,
    fillColor: fillColor,
    hintText: "Search...",
    prefixIcon: prefixIcon,
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(context) {
    return TextField(
      decoration: decor,
      controller: controller,
      cursorColor: textColor,
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      onSubmitted: (text) => context.dex.filter(text),
    );
  }
}
