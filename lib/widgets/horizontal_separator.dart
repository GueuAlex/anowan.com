import 'package:flutter/material.dart';

import '../config/palette.dart';

Container horizontalSeparator({
  double width = 60,
  double height = 2,
  Color color = Palette.separatorColor,
  double vpadding = 5,
}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: vpadding),
      width: width,
      height: height,
      color: color,
    );
