import 'package:flutter/material.dart';
import 'package:pokedex/widgets/_misc/clippers.dart';

typedef Clipper = CustomClipper<Path>;

class PageButtons extends StatelessWidget {
  const PageButtons({
    super.key,
    required this.prev,
    required this.next,
    this.pads = EdgeInsets.zero,
    this.shaded = false,
    this.hidden = false,
    this.spaceH = 0.09,
    this.spaceV = 0.1,
  });

  final Function() prev;
  final Function() next;

  final EdgeInsets pads;
  final double spaceH;
  final double spaceV;

  final bool shaded;
  final bool hidden;

  static const Icon iconLeft = Icon(Icons.arrow_left);
  static const Icon iconRight = Icon(Icons.arrow_right);

  @override
  Widget build(context) {
    final Clipper clipLeft = SlantVerticalRight(0, spaceV);
    final Clipper clipRight = SlantVerticalLeft(0, spaceV);

    return Visibility(
      visible: !hidden,
      child: LayoutBuilder(builder: (context, constraints) {
        final double width = constraints.maxWidth * spaceH;

        return Padding(
          padding: pads,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageButton(prev, clipLeft, iconLeft, width, shaded),
              PageButton(next, clipRight, iconRight, width, shaded),
            ],
          ),
        );

        //
      }),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.func, this.clipper, this.icon, this.width, this.shaded, {super.key});
  final Function() func;
  final Clipper clipper;
  final Icon icon;

  final double width;
  final bool shaded;

  static final shade = Colors.black.withOpacity(0.3);

  @override
  Widget build(context) {
    return ClipPath(
      clipper: clipper,
      child: Container(
        width: width,
        height: double.infinity,
        alignment: Alignment.center,
        color: shaded ? shade : null,
        child: Center(
          child: IconButton(
            icon: icon,
            iconSize: width / 2,
            onPressed: func,
            splashRadius: 0.1,
            alignment: Alignment.center,
            color: Colors.grey.shade900,
          ),
        ),
      ),
    );
  }
}
