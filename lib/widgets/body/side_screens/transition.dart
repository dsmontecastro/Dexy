// import 'dart:async';

import 'package:flutter/material.dart';

class Transition extends StatefulWidget {
  const Transition(this.constraint, this.controller, {super.key});
  final AnimationController controller;
  final BoxConstraints constraint;

  @override
  SideState createState() => SideState();
}

class SideState extends State<Transition> {
  // Offsets
  static const _bot = Offset(0, 1);
  static const _mid = Offset(0, 0);
  static const _top = Offset(0, -1);

  // Tweens
  static final _topSlide = Tween<Offset>(begin: _top, end: _mid);
  static final _botSlide = Tween<Offset>(begin: _bot, end: _mid);

  // Late Calls
  late final _controller = widget.controller;
  late final double _width = widget.constraint.maxWidth;
  late final double _height = widget.constraint.maxHeight / 2;

  @override
  Widget build(context) {
    // Build Proper

    final Widget box = Container(
      width: _width,
      height: _height,
      decoration: const BoxDecoration(color: Colors.black),
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: Column(
        children: [
          SlideTransition(
            position: _controller.drive(_topSlide),
            child: box,
          ),
          SlideTransition(
            position: _controller.drive(_botSlide),
            child: box,
          ),
        ],
      ),
    );
  }
}
