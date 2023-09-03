import 'package:flutter/material.dart';

class TitleInfo extends StatelessWidget {
  const TitleInfo(this.name, this.genus, {super.key});
  final String genus;
  final String name;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: InfoText(name, 75)),
            Expanded(flex: 1, child: InfoText(genus, 25)),
          ],
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText(this.text, this.size, {super.key});
  final String text;
  final int size;

  @override
  Widget build(context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Text(
        text,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
