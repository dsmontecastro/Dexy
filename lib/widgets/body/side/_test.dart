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
  const Test(this.id, {super.key});
  final int id;

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: colors[id],
      ),
      child: Center(child: Text("SideItem#$id")),
    );
  }
}
