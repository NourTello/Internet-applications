import 'package:flutter/material.dart';

import '../const/light-colors.dart';

TextStyle buttonTextStyle(
    {Color color = Colors.white,
    double fontSize = 20,
    var fontWeight = FontWeight.bold}) {
  return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
}

TextStyle titleTextStyle({double size = 20, Color color = primaryColor}) =>
    TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: size);

TextStyle greyTextStyle() => TextStyle(
      color: darkGrey,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
TextStyle normalTextStyle({textColor}) {
  if (textColor == null) textColor = thirdColor;
  return TextStyle(color: textColor, fontSize: 15,decoration: TextDecoration.none);
}
