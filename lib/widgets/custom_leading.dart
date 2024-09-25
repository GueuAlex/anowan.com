import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Palette.blackColor.withOpacity(0.7),
        ),
        child: Center(
          child: Icon(
            Platform.isIOS
                ? CupertinoIcons.chevron_back
                : CupertinoIcons.arrow_left,
            color: Palette.whiteColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
