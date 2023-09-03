import 'package:flutter/material.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

class TitleOrder extends StatelessWidget {
  const TitleOrder(this.order, {super.key});
  final String order;

  @override
  Widget build(context) {
    //

    final text = FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        "#$order ",
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        return Stack(
          children: [
            OrderBanner(width, Colors.white),
            OrderBanner(width * 0.975, Colors.black),
            OrderBanner(width * 0.925, Colors.white),
            OrderBanner(width * 0.900, Colors.black),
            Container(
              width: width * 0.81,
              alignment: Alignment.center,
              child: text,
            )
          ],
        );
      },
    );
  }
}

class OrderBanner extends StatelessWidget {
  const OrderBanner(this.width, this.color, {super.key});
  final double width;
  final Color color;

  @override
  Widget build(context) {
    return ClipPath(
      clipper: SlantRight(0.9),
      child: Container(
        width: width,
        height: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
