import 'package:flutter/material.dart';

class PageButtons extends StatelessWidget {
  const PageButtons({
    super.key,
    required this.prev,
    required this.next,
    this.padding = EdgeInsets.zero,
    this.shaded = false,
    this.hidden = false,
    this.space = 0.09,
  });

  final Function() prev;
  final Function() next;

  final EdgeInsets padding;
  final double space;
  final bool shaded;
  final bool hidden;

  static const Icon iconRight = Icon(Icons.arrow_right);
  static const Icon iconLeft = Icon(Icons.arrow_left);

  @override
  Widget build(context) {
    return Visibility(
      visible: !hidden,
      child: LayoutBuilder(builder: (context, constraints) {
        final double width = constraints.maxWidth * space;

        return Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageButton(iconLeft, width, shaded, prev),
              PageButton(iconRight, width, shaded, next),
            ],
          ),
        );

        //
      }),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.icon, this.width, this.shaded, this.func, {super.key});
  final Function() func;
  final double width;
  final bool shaded;
  final Icon icon;

  static final shade = Colors.black.withOpacity(0.3);

  @override
  Widget build(context) {
    final double iconWidth = width * 0.5;

    return Container(
      width: width,
      height: double.infinity,
      alignment: Alignment.center,
      color: shaded ? shade : null,
      child: Center(
        child: IconButton(
          icon: icon,
          iconSize: iconWidth,
          onPressed: func,
          splashRadius: 0.1,
          alignment: Alignment.center,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}
