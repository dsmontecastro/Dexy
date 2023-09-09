import 'package:flutter/material.dart';
import 'package:pokedex/extensions/num.dart';

class SlantRightUp extends CustomClipper<Path> {
  SlantRightUp(this.offset);
  final double offset;

  @override
  Path getClip(Size size) {
    assert(offset.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.lineTo(0, h);
    path.lineTo(w * offset, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class SlantRightDown extends CustomClipper<Path> {
  SlantRightDown(this.offset);
  final double offset;

  @override
  Path getClip(Size size) {
    assert(offset.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w * offset, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
