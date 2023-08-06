import 'package:flutter/material.dart';

class Drawers extends ChangeNotifier {
  static final GlobalKey<ScaffoldState> _navKey = GlobalKey();
  static final GlobalKey<ScaffoldState> _sideKey = GlobalKey();

  GlobalKey<ScaffoldState> get navKey => _navKey;
  GlobalKey<ScaffoldState> get sideKey => _sideKey;

  void drawNav() {
    ScaffoldState? state = _navKey.currentState;
    if (state != null && state.hasDrawer) {
      if (state.isDrawerOpen) {
        state.closeDrawer();
      } else {
        state.openDrawer();
      }
    }
  }

  void drawSide() {
    ScaffoldState? state = _sideKey.currentState;
    if (state != null && state.hasEndDrawer) {
      if (state.isEndDrawerOpen) {
        state.closeEndDrawer();
      } else {
        state.openEndDrawer();
      }
    }
  }
}
