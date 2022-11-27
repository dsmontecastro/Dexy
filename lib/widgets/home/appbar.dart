import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String logoPath = "assets/images/logo.svg";

AppBar homeAppBar(
  Function draw,
  TextEditingController searchController,
) {
  return AppBar(
    // Title: Search Bar
    title: SearchBar(controller: searchController),
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
  const SearchBar({super.key, required this.controller});
  final TextEditingController controller;

  static final Color fillColor = Colors.grey.shade600;
  static final Color textColor = Colors.red.shade600;

  static Icon prefixIcon = Icon(
    Icons.search,
    color: textColor,
  );

  @override
  Widget build(context) {
    return SizedBox(
        height: 35,
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: TextField(
            controller: controller,
            cursorColor: textColor,
            keyboardType: TextInputType.text,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Search...",
              filled: true,
              fillColor: fillColor,
              prefixIcon: prefixIcon,
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onSubmitted: (text) {
              // Navigator.pushNamed(context, Routes.search, arguments: {text: controller.text});
              // print(controller.text);
            },
          ),
        ));
  }
}
