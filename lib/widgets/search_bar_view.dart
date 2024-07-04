import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';
import '../config/palette.dart';

Container searcheBarView({
  required Size size,
  String text = 'Découvrez les évènements à venir',
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Palette.primaryColor.withOpacity(0.1),
    ),
    child: Row(
      children: [
        Icon(
          FluentIcons.search_12_regular,
          color: Colors.grey.shade500,
          size: 22,
        ),
        const Gap(5),
        AppText.medium(
          text,
          color: Colors.grey.shade500,
          fontSize: (size.width * 0.038),
          fontWeight: FontWeight.w300,
        )
      ],
    ),
  );
}
