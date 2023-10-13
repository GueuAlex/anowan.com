import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../config/palette.dart';

class AddForiteButton extends StatelessWidget {
  const AddForiteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Palette.whiteColor.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          FluentIcons.heart_24_regular,
          color: Palette.blackColor,
          size: 20,
        ),
      ),
    );
  }
}
