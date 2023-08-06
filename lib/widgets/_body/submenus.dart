import 'package:flutter/material.dart';

import 'scroll_menu.dart';
// import 'package:pokedex/extensions/provider.dart';

// import 'package:pokedex/database/services.dart';
// import 'package:pokedex/database/models/species.dart';

// const int menuCount = Dex.menuCount;
// const int rad = menuCount ~/ 2;

class Menus extends StatefulWidget {
  const Menus(this.size, {super.key});
  final Size size;

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menus> {
  int index = 0;
  static const max = 3;
  static const Icon icon = Icon(Icons.deck);
  static List<Widget> menus = List.generate(max, (i) => Center(child: Text("Menu#$i")));

  void swap() => setState(() => index = (index + 1) % max);

  // final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // void draw() {
  //   setState(() {
  //     ScaffoldState? key = drawerKey.currentState;
  //     if (key != null) {
  //       if (key.isDrawerOpen) {
  //         key.closeDrawer();
  //       } else {
  //         key.openDrawer();
  //       }
  //     }
  //   });
  // }

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
      // width: double.infinity,
      width: widget.size.width / 2,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(vertical: size.height / 15),
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
    );

    // Widget drag = DraggableScrollableSheet(
    //   expand: false,
    //   maxChildSize: 1.0,
    //   minChildSize: 0.2,
    //   initialChildSize: 0.2,
    //   builder: (context, controller) {
    //     return SingleChildScrollView(
    //       controller: controller,
    //       child: Container(
    //         width: 400,
    //         height: 90,
    //         alignment: Alignment.centerLeft,
    //         padding: EdgeInsets.zero,
    //         decoration: const BoxDecoration(
    //           color: Colors.red,
    //         ),
    //         child: const Text("HERE"),
    //       ),
    //     );
    //   },
    // );

    // return Stack(
    //   fit: StackFit.expand,
    //   alignment: AlignmentDirectional.bottomStart,
    //   children: [
    //     main,
    //     drag,
    //   ],
    // );

    // return DraggableScrollableSheet(builder: (context, controller) {
    //   return ListView.builder(
    //     itemCount: max,
    //     itemBuilder: (context, index) => menus[index],
    //   );
    // });

    return Expanded(
      child: Column(
        children: [
          Expanded(child: main),
          Expanded(
            child: IndexedStack(
              index: index,
              alignment: AlignmentDirectional.bottomStart,
              children: menus,
            ),
          ),
        ],
      ),
    );
  }
}
