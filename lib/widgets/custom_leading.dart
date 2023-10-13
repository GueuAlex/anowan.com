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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Palette.whiteColor.withOpacity(0.9),
        ),
        child: Center(
          child: Icon(
            Platform.isIOS
                ? CupertinoIcons.chevron_back
                : CupertinoIcons.arrow_left,
            color: Palette.blackColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
