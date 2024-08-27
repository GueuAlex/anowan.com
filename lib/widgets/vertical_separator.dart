import 'package:flutter/material.dart';

import '../config/palette.dart';

Container verticalSeparator(
    {double height = 25,
    double width = 2,
    Color color = Palette.separatorColor}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    width: width,
    height: height,
    color: color,
  );
}
