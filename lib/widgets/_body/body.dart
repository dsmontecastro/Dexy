import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'body/_test.dart';
import 'body/side_menu.dart';
import 'body/side_menu_h.dart';
import 'body/submenus.dart';
import 'body/main_menu.dart';
import 'body/scroll_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  // static const List<Widget> children = [MainMenu(), ScrollMenu()];
  static const List<Widget> children = [Text("MAIN"), SideMenu()];

  @override
  Widget build(context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final Size size = MediaQuery.of(context).size;
        final bool flag = orientation == Orientation.portrait;
        final Axis direction = flag ? Axis.vertical : Axis.horizontal;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Flex(
            direction: direction,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(
                child: MainMenu(),
              ),

              Expanded(child: Center(child: Text("XXXX"))),
              // Expanded(child: SideH()),
              // Expanded(
              // child: Scaffold(
              //   body: SizedBox.expand(
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         color: Colors.red,
              //       ),
              //       child: const Center(child: Text("BODY")),
              //     ),
              //   ),
              //   endDrawer: Drawer(),
              // ),
              //     child: Stack(
              //   fit: StackFit.expand,
              //   alignment: AlignmentDirectional.bottomStart,
              //   children: [
              //     // ScrollMenu(),
              //     SizedBox.expand(
              //       child: Container(
              //         decoration: const BoxDecoration(color: Colors.blue),
              //         child: const Center(child: Text("TEMP")),
              //       ),
              //     ),
              //     // const Center(child: Text("TEMP")),
              //     Test(
              //       width: flag ? size.width : size.width / 2,
              //       height: flag ? size.height / 2 : size.width,
              //     ),
              //   ],
              // ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
