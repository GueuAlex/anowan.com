import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Row textMidleLine({String text = 'Continuer le paiement avec'}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          width: double.infinity,
          height: 1,
          color: Palette.separatorColor,
        ),
      ),
      AppText.medium(
        text,
        fontWeight: FontWeight.w300,
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 1,
          color: Palette.separatorColor,
        ),
      )
    ],
  );
}
