import 'package:flutter/material.dart';

const List<Color> colors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];

final List<Widget> testPages = List.generate(5, (index) => Test(index + 1));

class Test extends StatelessWidget {
  const Test(this.id, {super.key});
  final int id;

  @override
  Widget build(context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: colors[id],
        ),
        child: Center(child: Text("SideItem#$id")),
      ),
    );
  }
}
