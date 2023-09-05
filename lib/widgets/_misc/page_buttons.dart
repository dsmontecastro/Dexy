import 'package:flutter/material.dart';

class PageButtons extends StatelessWidget {
  const PageButtons({
    super.key,
    required this.prev,
    required this.next,
    this.padding = EdgeInsets.zero,
    this.shaded = false,
    this.hidden = false,
  });

  final Function() prev;
  final Function() next;

  final EdgeInsets padding;
  final bool shaded;
  final bool hidden;

  static const Icon iconRight = Icon(Icons.arrow_right);
  static const Icon iconLeft = Icon(Icons.arrow_left);

  @override
  Widget build(context) {
    return Visibility(
      visible: !hidden,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageButton(iconLeft, shaded, prev),
            PageButton(iconRight, shaded, next),
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.icon, this.shaded, this.func, {super.key});
  final Function() func;
  final bool shaded;
  final Icon icon;

  static final shade = Colors.black.withOpacity(0.3);

  @override
  Widget build(context) {
    return Container(
      color: shaded ? shade : null,
      height: double.infinity,
      child: IconButton(
        icon: icon,
        onPressed: func,
        color: Colors.grey,
        splashRadius: 0.1,
      ),
    );
  }
}
