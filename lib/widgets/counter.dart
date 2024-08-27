import 'package:flutter/material.dart';

import '../config/app_text.dart';

Expanded counter(
    {required int count,
    String text = 'Organisateurs suivis',
    double fontSize = 24}) {
  return Expanded(
    child: Column(
      children: [
        AppText.large(
          count.toString(),
          fontSize: fontSize,
        ),
        AppText.medium(
          text,
          textOverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w300,
        )
      ],
    ),
  );
}
