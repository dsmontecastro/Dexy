import 'package:flutter/material.dart';

class Drawers extends ChangeNotifier {
  static final GlobalKey<ScaffoldState> _key = GlobalKey();
  GlobalKey<ScaffoldState> get key => _key;

  void drawNav() {
    ScaffoldState? state = _key.currentState;
    if (state != null && state.hasDrawer) {
      if (state.isDrawerOpen) {
        state.closeDrawer();
      } else {
        state.openDrawer();
      }
    }
  }

  void drawSide() {
    ScaffoldState? state = _key.currentState;
    if (state != null && state.hasEndDrawer) {
      if (state.isEndDrawerOpen) {
        state.closeEndDrawer();
      } else {
        state.openEndDrawer();
      }
    }
  }
}
