import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Container normalTitleContainer({required String title, required Size size}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    width: double.infinity,
    child: AppText.medium(
      title,
      textOverflow: TextOverflow.ellipsis,
      maxLine: 3,
      fontSize: size.width * 0.04,
      color: Palette.blackColor,
      fontWeight: FontWeight.w800,
    ),
  );
}

Container offsetTitleContainer({required String title, required Size size}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    width: double.infinity,
    child: AppText.medium(
      title,
      textOverflow: TextOverflow.ellipsis,
      maxLine: 1,
      fontSize: size.width * 0.04,
      color: Palette.blackColor,
      fontWeight: FontWeight.w800,
      textAlign: TextAlign.center,
    ),
  );
}
