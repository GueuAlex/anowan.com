import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _button(),
          Gap(5),
          _button(string: 'Partager le profile'),
          Gap(5),
          _button(string: 'assets/icons/a.svg', isSvg: true, ph: 8),
        ],
      ),
    );
  }

  InkWell _button({
    String string = 'Suivre',
    bool isSvg = false,
    double ph = 25,
  }) {
    return InkWell(
      child: Container(
        height: 35,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: ph, vertical: 5),
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.14),
          borderRadius: BorderRadius.circular(5),
        ),
        child: isSvg
            ? SvgPicture.asset(string, width: 18)
            : AppText.medium(string, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
