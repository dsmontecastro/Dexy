import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
// import 'package:pokedex/database/models/_model.dart';

const Icon back = Icon(Icons.arrow_back);
const Icon load = Icon(Icons.refresh);

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      //

      return Drawer(
        width: constraints.maxWidth / 3,
        shadowColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: back,
              alignment: Alignment.topLeft,
              onPressed: context.drawNav,
            ),
            const NavMenu(),
            IconButton(
              icon: load,
              alignment: Alignment.bottomLeft,
              onPressed: () => {},
              // onPressed: () {
              //   print("DEBUGGING!");
              //   // context.db.drop(Models.pokemon);
              //   // context.db.callAPI(table: Models.pokemon);
              //   context.db.drop(Models.species);
              //   context.db.callAPI(table: Models.species);
              // },
            ),
          ],
        ),
      );

      //
    });
  }
}

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(context) {
    return const Expanded(child: Column());
  }
}
