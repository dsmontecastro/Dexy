import 'package:flutter/material.dart';

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
      clipper: SlantRight(),
      child: Container(
        width: width,
        height: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}

class SlantRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.lineTo(0, h);
    path.lineTo(w * 0.9, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
