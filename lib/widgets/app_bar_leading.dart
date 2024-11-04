import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      highlightColor: Colors.transparent,
      onTap: () => Navigator.pop(context),
      child: Icon(
        Platform.isIOS ? CupertinoIcons.back : CupertinoIcons.arrow_left,
        color: Colors.black87,
      ),
    );
  }
}
