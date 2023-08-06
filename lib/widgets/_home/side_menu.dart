import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  static void doNothing(BuildContext c) {}

  // int index = 0;
  // static const max = 3;
  // static const Icon icon = Icon(Icons.deck);
  // static List<Widget> menus = List.generate(max, (i) => Center(child: Text("Menu#$i")));

  // void swap() => setState(() => index = (index + 1) % max);

  @override
  Widget build(context) {
    //

    // Widget main = Column(
    //   children: [
    //     IconButton(icon: icon, onPressed: swap),
    //     const Expanded(child: ScrollMenu()),
    //   ],
    // );

    Widget main = Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(vertical: size.height / 15),
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
    );

    Widget drag = DraggableScrollableSheet(
      expand: false,
      maxChildSize: 1.0,
      minChildSize: 0.2,
      initialChildSize: 0.2,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Container(
            width: 400,
            height: 90,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: const Text("HERE"),
          ),
        );
      },
    );

    final size = MediaQuery.of(context).size;

    Widget slider = Container(
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(color: Colors.blue),
      child: Slidable(
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [Text("HERE I AM!")],
        ),
        child: Container(
          alignment: Alignment.centerRight,
          width: size.width * 0.1,
          height: size.height,
          decoration: const BoxDecoration(color: Colors.red),
          child: const Text("SLIDE ME!"),
        ),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.bottomStart,
      children: [
        main,
        // drag,
        slider,
      ],
    );
  }
}
