import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  static const bgColor = Color.fromARGB(255, 177, 177, 177);

  @override
  Widget build(context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/hex.png',
        repeat: ImageRepeat.repeat,
        color: bgColor,
      ),
    );
  }
}
