import 'package:flutter/material.dart';

class SlantRight extends CustomClipper<Path> {
  SlantRight(this.offset);
  final double offset;

  @override
  Path getClip(Size size) {
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
