import 'package:flutter/material.dart';

class TitleInfo extends StatelessWidget {
  const TitleInfo(this.name, this.genus, {super.key});
  final String genus;
  final String name;

  static const alignment = Alignment.centerLeft;
  static const constraints = BoxConstraints.expand();

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;

      final padding = EdgeInsets.only(bottom: height * 0.2);

      return Padding(
        padding: padding,
        child: Container(
          alignment: alignment,
          constraints: constraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: InfoText(name, 30)),
              Expanded(flex: 1, child: InfoText(genus, 25)),
            ],
          ),
        ),
      );

      //
    });
  }
}

class InfoText extends StatelessWidget {
  const InfoText(this.text, this.size, {super.key});
  final String text;
  final double size;

  @override
  Widget build(context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(
          fontSize: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
