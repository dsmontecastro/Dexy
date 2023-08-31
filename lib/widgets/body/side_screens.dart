import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'side_screens/_pages.dart';
// import 'side_screens/transition.dart';

class SideScreen extends StatefulWidget {
  const SideScreen({super.key});

  @override
  SideScreenState createState() => SideScreenState();
}

class SideScreenState extends State<SideScreen> with TickerProviderStateMixin {
  static const Icon _iconRight = Icon(Icons.arrow_right);
  static const Icon _iconLeft = Icon(Icons.arrow_left);

  // Transition Animation Elements ---------------------------------------------

  static const _duration = Duration(milliseconds: 150);
  static const _reverseDuration = Duration(milliseconds: 100);

  bool _animating = false;

  late final AnimationController _animControl = AnimationController(
    vsync: this,
    duration: _duration,
    reverseDuration: _reverseDuration,
    animationBehavior: AnimationBehavior.preserve,
  );

  void transition() {
    _animControl.forward();
    Timer(_duration * 2.5, () {
      _animControl.reverse();
    });
  }

  // PageView Elements ---------------------------------------------------------

  final PageController _pageControl = PageController(initialPage: 0);
  final List<Widget> _pages = pageList;
  int _page = 0;

  void nextPage() => swapPage(1);
  void prevPage() => swapPage(-1);

  void turnPage(int i) {
    if (!_animating) {
      setState(() {
        _page = (_page + i) % _pages.length;
        _pageControl.animateToPage(
          _page,
          curve: Curves.linear,
          duration: _duration,
        );
        Timer(_duration * 2, () {
          _animating = false;
        });
      });
    }
  }

  void swapPage(int i) {
    if (!_animating) {
      setState(() => _animating = true);
      transition();
      Timer(_duration * 2.75, () {
        setState(() {
          _page = (_page + i) % _pages.length;
          _pageControl.jumpToPage(_page);
          Timer(_duration * 2, () {
            _animating = false;
          });
        });
      });
    }
  }

  @override
  Widget build(context) {
    // Build Proper

    Widget stack = Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          dragStartBehavior: DragStartBehavior.start,
          physics: const ScrollPhysics(),
          controller: _pageControl,
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
        // IgnorePointer(
        //   child: LayoutBuilder(
        //     builder: (context, constraints) => Transition(
        //       constraints,
        //       _animControl,
        //     ),
        //   ),
        // ),
      ],
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          const int sens = 500;
          final double? velocity = details.primaryVelocity;
          debugPrint(velocity.toString());
          if (velocity != null) {
            if (velocity < -sens) {
              turnPage(1);
            } else if (velocity > sens) {
              turnPage(-1);
            }
          }
        },
        child: stack,
      ),
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
