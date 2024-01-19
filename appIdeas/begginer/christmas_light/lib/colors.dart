import 'package:flutter/material.dart';

Color darkenColor(Color color, {double factor = 0.7}) {
  int red = (color.red * factor).round();
  int green = (color.green * factor).round();
  int blue = (color.blue * factor).round();

  return Color.fromRGBO(red, green, blue, 1.0);
}

const Color colorRedOff = Color(0xFF800000); // Darker red color
final Color colorRedOn = Colors.red.shade600;
const Color colorRedShadow = Colors.red;
final Color colorBlueOff = darkenColor(Colors.blue); // Darkened blue color
final Color colorBlueOn = Colors.blue.shade600;
const Color colorBlueShadow = Colors.blue;
final Color colorGreenOff = darkenColor(Colors.green); // Darkened green color
final Color colorGreenOn = Colors.green.shade600;
const Color colorGreenShadow = Colors.green;
final Color colorOrangeOff =
    darkenColor(Colors.orange); // Darkened orange color
final Color colorOrangeOn = Colors.orange.shade600;
const Color colorOrangeShadow = Colors.orange;
final Color colorPurpleOff =
    darkenColor(Colors.purple); // Darkened purple color
final Color colorPurpleOn = Colors.purple.shade600;
const Color colorPurpleShadow = Colors.purple;
