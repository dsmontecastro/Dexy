import 'package:flutter/material.dart';

import 'side/_test.dart';
import 'side/transition.dart';

class Side extends StatefulWidget {
  const Side({super.key});

  @override
  SideState createState() => SideState();
}

class SideState extends State<Side> {
  static const Icon _iconLeft = Icon(Icons.arrow_left);
  static const Icon _iconRight = Icon(Icons.arrow_right);
  static const Duration _duration = Duration(microseconds: 50);

  final PageController _controller = PageController(initialPage: 0);
  final List<Widget> _pages = testPages;
  int _page = 0;

  void nextPage() => swapPage(1);
  void prevPage() => swapPage(-1);

  void swapPage(int i) {
    setState(() {
      _page = (_page + i) % _pages.length;
      _controller.animateToPage(
        _page,
        curve: Curves.ease,
        duration: _duration,
      );
    });
  }

  @override
  Widget build(context) {
    // Build Proper
    // final Size size = MediaQuery.of(context).size;

    Widget stack = Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          physics: const ScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageButton(_iconLeft, prevPage),
                PageButton(_iconRight, nextPage),
              ],
            ),
          ),
        ),
        LayoutBuilder(builder: (context, constraints) => Transition(constraints)),
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
