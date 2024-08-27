import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';

import '../config/palette.dart';

Row sheetCloserCross({required BuildContext ctxt, String text = ''}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Gap(35),
        Expanded(
          child: AppText.medium(text, textAlign: TextAlign.center),
        ),
        InkWell(
          onTap: () => Navigator.pop(ctxt),
          child: Container(
            width: 35,
            height: 30,
            decoration: BoxDecoration(
              color: Palette.separatorColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.close,
                color: Colors.black54,
                size: 15,
              ),
            ),
          ),
        )
      ],
    );
