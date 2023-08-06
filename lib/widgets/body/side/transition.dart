import 'dart:async';

import 'package:flutter/material.dart';

class Transition extends StatefulWidget {
  const Transition(this.size, {super.key});
  final BoxConstraints size;

  @override
  SideState createState() => SideState();
}

class SideState extends State<Transition> with TickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 250);
  static const _reverse = Duration(milliseconds: 100);
  static const topPos = Offset(0, -1);
  static const topEnd = Offset(0, 0);
  static const botPos = Offset(0, 1);
  static const botEnd = Offset(0, 0);

  late final AnimationController _topControl;
  late final AnimationController _botControl;
  late final Animation<Offset> _topAnim;
  late final Animation<Offset> _botAnim;
  late final double _height;
  late final double _width;

  bool playing = false;

  @override
  void initState() {
    super.initState();

    BoxConstraints size = widget.size;
    _height = size.maxHeight / 2;
    _width = size.maxWidth;

    final topSlide = Tween<Offset>(begin: topPos, end: topEnd);
    final botSlide = Tween<Offset>(begin: botPos, end: botEnd);

    _topControl = AnimationController(
      vsync: this,
      duration: _duration,
      reverseDuration: _reverse,
    );

    _botControl = AnimationController(
      vsync: this,
      duration: _duration,
      reverseDuration: _reverse,
    );

    _topAnim = _topControl.drive(topSlide);
    _botAnim = _botControl.drive(botSlide);
  }

  void toggle() {
    debugPrint("toggled");
    _topControl.forward();
    _botControl.forward();

    Timer(_duration * 2, () {
      _topControl.reverse();
      _botControl.reverse();
    });
  }

  @override
  Widget build(context) {
    // Build Proper

    final Widget _box = Container(
      width: _width,
      height: _height,
      decoration: const BoxDecoration(color: Colors.black),
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(vertical: size.height / 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          IgnorePointer(
            child: Column(
              children: [
                SlideTransition(
                    position: _topAnim,
                    child: Container(
                      width: _width,
                      height: _height,
                      decoration: const BoxDecoration(color: Colors.red),
                    )),
                SlideTransition(
                    position: _botAnim,
                    child: Container(
                      width: _width,
                      height: _height,
                      decoration: const BoxDecoration(color: Colors.green),
                    )),
              ],
            ),
          ),
          Center(
            child: IconButton(
              icon: const Icon(Icons.deck),
              onPressed: toggle,
            ),
          ),
        ],
      ),
    );
  }
}
