import 'package:flutter/material.dart';

import '../../../config/palette.dart';

class RedirectTo extends StatelessWidget {
  const RedirectTo({
    super.key,
    required this.size,
    required this.text,
    required this.onPressed,
    required this.question,
  });

  final Size size;
  final String text;
  final VoidCallback onPressed;
  final String question;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: question,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: size.height * 0.015),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w400,
                color: Palette.appRed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
