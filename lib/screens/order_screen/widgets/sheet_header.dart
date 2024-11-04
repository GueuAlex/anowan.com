import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Container sheetheader({
  required BuildContext context,
  String text = 'Date et lieu',
  double hopacity = 0.15,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(hopacity),
      border: Border(
        bottom: BorderSide(
          width: 0.8,
          color: Palette.separatorColor,
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        AppText.medium(
          text,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.xmark,
                color: Color.fromARGB(255, 20, 20, 20),
                size: 16,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
