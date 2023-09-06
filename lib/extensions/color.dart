import 'package:flutter/material.dart';

extension Change on Color {
  //

  Color withHue(double amount) {
    final base = HSLColor.fromColor(this);
    final double value = amount.clamp(0, 360);
    return base.withHue(value).toColor();
  }

  Color withLightness(double amount) {
    final base = HSLColor.fromColor(this);
    final double value = amount.clamp(0, 1);
    return base.withLightness(value).toColor();
  }

  Color withSaturation(double amount) {
    final base = HSLColor.fromColor(this);
    final double value = amount.clamp(0, 1);
    return base.withSaturation(value).toColor();
  }

  //
}
