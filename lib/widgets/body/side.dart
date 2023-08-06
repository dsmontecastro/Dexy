import 'package:flutter/material.dart';

import 'package:pokedex/providers/dex.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/database/models/species.dart';

import 'side/_test.dart';

const int menuCount = Dex.menuCount;
const int rad = menuCount ~/ 2;

class Side extends StatefulWidget {
  const Side({super.key});

  @override
  SideState createState() => SideState();
}

class SideState extends State<Side> {
  static const Icon _iconLeft = Icon(Icons.arrow_left);
  static const Icon _iconRight = Icon(Icons.arrow_right);
  static const Duration _duration = Duration(microseconds: 50);

  int _page = 0;
  static const int _pageCount = 5;
  final PageController _controller = PageController(initialPage: 0);

  static final List<Widget> _pages = List.generate(
    _pageCount,
    (index) => Expanded(child: Center(child: Test(index + 1))),
  );

  void swapPage(int i) {
    setState(() {
      // debugPrint("Page: $_page to ${_page + i}");
      _page = (_page + i) % _pageCount;
      _controller.animateToPage(
        _page,
        curve: Curves.ease,
        duration: _duration,
      );
    });
  }

  void nextPage() => swapPage(1);
  void prevPage() => swapPage(-1);

  @override
  Widget build(context) {
    // Build Proper

    Widget stack = Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          physics: const ScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageButton(_iconLeft, prevPage),
            PageButton(_iconRight, nextPage),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(vertical: size.height / 15),
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: stack,
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.icon, this.func, {super.key});
  final Function() func;
  final Icon icon;

  @override
  Widget build(context) {
    return IconButton(
      icon: icon,
      color: Colors.grey,
      onPressed: func,
    );
  }
}
