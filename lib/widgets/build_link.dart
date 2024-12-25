import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';

Widget link(
    {required String svgPath,
    required String text,
    required String subText,
    required VoidCallback onTap,
    double pb = 0}) {
  return Padding(
    padding: EdgeInsets.only(bottom: pb),
    child: InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(svgPath),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(
                    text,
                    fontWeight: FontWeight.w700,
                  ),
                  AppText.small(
                    subText,
                    maxLine: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              )
            ],
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.black54,
            size: 15,
          ),
        ],
      ),
    ),
  );
}
