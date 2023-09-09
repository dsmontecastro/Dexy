import 'package:flutter/material.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

class TitleOrder extends StatelessWidget {
  const TitleOrder(this.order, {super.key});
  final int order;

  @override
  Widget build(context) {
    //

    final String id = order.toString().padLeft(4, "0");

    final text = FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        "#$id",
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              alignment: Alignment.center,
              width: width * 0.875,
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
      clipper: SlantRightUp(0.9),
      child: Container(
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
