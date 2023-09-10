import 'package:flutter/material.dart';
import 'package:pokedex/extensions/num.dart';

class SlantRightUp extends CustomClipper<Path> {
  const SlantRightUp(this.offset);
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
  const SlantRightDown(this.offset);
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

class SlantVerticalRight extends CustomClipper<Path> {
  const SlantVerticalRight(this.offH, this.offV);
  final double offH;
  final double offV;

  @override
  Path getClip(Size size) {
    assert(offV.inRange(0, 0.5));
    assert(offH.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.lineTo(w * offH, 0);
    path.lineTo(w, h * offV);
    path.lineTo(w, h * (1 - offV));
    path.lineTo(w * offH, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class SlantVerticalLeft extends CustomClipper<Path> {
  const SlantVerticalLeft(this.offH, this.offV);
  final double offH;
  final double offV;

  @override
  Path getClip(Size size) {
    assert(offV.inRange(0, 0.5));
    assert(offH.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w, 0);
    path.lineTo(w * offH, 0);
    path.lineTo(0, h * offV);
    path.lineTo(0, h * (1 - offV));
    path.lineTo(w * offH, h);
    path.moveTo(w, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class RoundRight extends CustomClipper<Path> {
  const RoundRight(this.offset);
  final double offset;

  @override
  Path getClip(Size size) {
    assert(offset.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;
    final o = w * offset;

    path.lineTo(o, 0);
    path.quadraticBezierTo(w, h / 2, o, h);
    path.lineTo(o, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class TriangleRight extends CustomClipper<Path> {
  const TriangleRight(this.inset);
  final double inset;

  @override
  Path getClip(Size size) {
    assert(inset.inRange(0, 1));

    final path = Path();
    final w = size.width;
    final h = size.height;
    final i = w * inset;

    path.lineTo(w, h / 2);
    path.lineTo(0, h);
    path.lineTo(i, h / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
