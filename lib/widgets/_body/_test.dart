import 'package:flutter/material.dart';

import 'scroll_menu.dart';
// import 'package:pokedex/extensions/provider.dart';

// import 'package:pokedex/database/services.dart';
// import 'package:pokedex/database/models/species.dart';

// const int menuCount = Dex.menuCount;
// const int rad = menuCount ~/ 2;

class Test extends StatefulWidget {
  const Test({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  final double _offset = 30;

  bool _init = true;
  double _drawerLeft = 400;
  IconData _drawerIcon = Icons.arrow_back_ios;

  @override
  Widget build(BuildContext context) {
    if (_init) {
      _drawerLeft = MediaQuery.of(context).size.width - _offset;
      _init = false;
    }

    //
    Widget x = Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.25,
        heightFactor: 1,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                    child: Text(
                  'text',
                  style: TextStyle(fontSize: 32),
                )),
              ),
            ),
            Positioned.fill(
              right: 0,
              child: Opacity(
                opacity: 1 - _drawerLeft / (MediaQuery.of(context).size.width - _offset),
                child: ModalBarrier(dismissible: false, color: Colors.black87),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 3 / 4,
              top: 0,
              height: MediaQuery.of(context).size.height / 2,
              left: _drawerLeft,
              child: GestureDetector(
                  onPanUpdate: (details) {
                    _drawerLeft += details.delta.dx;
                    if (_drawerLeft <= MediaQuery.of(context).size.width / 4)
                      _drawerLeft = MediaQuery.of(context).size.width / 4;
                    if (_drawerLeft >= MediaQuery.of(context).size.width - _offset)
                      _drawerLeft = MediaQuery.of(context).size.width - _offset;
                    if (_drawerLeft <= MediaQuery.of(context).size.width / 3) _drawerIcon = Icons.arrow_forward_ios;
                    if (_drawerLeft >= MediaQuery.of(context).size.width - 2 * _offset)
                      _drawerIcon = Icons.arrow_back_ios;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: _offset),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                _drawerIcon,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'text',
                              style: TextStyle(color: Colors.white, fontSize: 32),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );

    //
    Widget y = Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.25,
        heightFactor: 1,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.grey[200],
                child: const Center(
                    child: Text(
                  'text',
                  style: TextStyle(fontSize: 32),
                )),
              ),
            ),
            Positioned.fill(
              right: 0,
              child: Opacity(
                opacity: 1 - _drawerLeft / (MediaQuery.of(context).size.width - _offset),
                child: const ModalBarrier(dismissible: false, color: Colors.black87),
              ),
            ),
            // Positioned(
            //   width: MediaQuery.of(context).size.width * 3 / 4,
            //   top: 0,
            //   height: MediaQuery.of(context).size.height / 2,
            //   left: _drawerLeft,
            //   child: GestureDetector(
            //       onPanUpdate: (details) {
            //         _drawerLeft += details.delta.dx;
            //         if (_drawerLeft <= MediaQuery.of(context).size.width / 4)
            //           _drawerLeft = MediaQuery.of(context).size.width / 4;
            //         if (_drawerLeft >= MediaQuery.of(context).size.width - _offset)
            //           _drawerLeft = MediaQuery.of(context).size.width - _offset;
            //         if (_drawerLeft <= MediaQuery.of(context).size.width / 3) _drawerIcon = Icons.arrow_forward_ios;
            //         if (_drawerLeft >= MediaQuery.of(context).size.width - 2 * _offset)
            //           _drawerIcon = Icons.arrow_back_ios;
            //         setState(() {});
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(color: Colors.blue),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: <Widget>[
            //             Padding(
            //               padding: EdgeInsets.only(right: _offset),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: <Widget>[
            //                   Icon(
            //                     _drawerIcon,
            //                     color: Colors.white,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 Text(
            //                   'text',
            //                   style: TextStyle(color: Colors.white, fontSize: 32),
            //                 )
            //               ],
            //             )
            //           ],
            //         ),
            //       )),
            // ),
          ],
        ),
      ),
    );

    //
    Widget z = SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
        child: const Center(child: Text("TEST")),
      ),
    );

    //
    Widget a = const Row(
      children: [
        Text("DRAWER_SPACE"),
        Drawer(),
      ],
    );

    return a;
  }
}
