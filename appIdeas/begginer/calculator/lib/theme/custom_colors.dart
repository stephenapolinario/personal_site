import 'package:flutter/material.dart';

class CustomColors {
  static Color getCustomColor(
      BuildContext context, Color lightColor, Color darkColor) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkColor
        : lightColor;
  }

  static Color bulbBackground(BuildContext context) {
    return getCustomColor(context, Colors.black, Colors.grey.shade700);
  }

  static Color calculatorBackground(BuildContext context) {
    return getCustomColor(context, Colors.grey.shade100, Colors.grey.shade700);
  }

  static Color normalButtonBackground(BuildContext context) {
    return getCustomColor(context, Colors.grey.shade600, Colors.white);
  }

  static Color operationButtonBackground(BuildContext context) {
    return getCustomColor(context, Colors.orange, Colors.orange);
  }

  static Color historyValue(BuildContext context) {
    return getCustomColor(context, Colors.grey.shade400, Colors.grey.shade400);
  }

  static Color especialButtonBackground(BuildContext context) {
    return getCustomColor(context, Colors.grey.shade200, Colors.grey.shade500);
  }
}
