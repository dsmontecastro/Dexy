import 'package:flutter/material.dart';

const List<Color> colors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];

class Test extends StatelessWidget {
  const Test(this.id, this.height, {super.key});
  final double height;
  final int id;

  static const constraints = BoxConstraints.expand();

  @override
  Widget build(context) {
    final text = "SideItem#${id % colors.length}";
    final color = colors[id % colors.length];

    return Column(
      children: [
        Container(height: height, color: Colors.grey.shade800),
        Expanded(
          child: Container(
            color: color,
            constraints: constraints,
            child: Center(child: Text(text)),
          ),
        ),
      ],
    );
  }
}
