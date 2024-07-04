import 'package:flutter/material.dart';

import '../../../config/palette.dart';

class TermsOfUs extends StatelessWidget {
  const TermsOfUs({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'En continuant, vous acceptez les ',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: size.height * 0.0148,
        ),
        children: [
          TextSpan(
            text: 'Conditions générales de service',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              color: Palette.appRed,
            ),
          ),
          TextSpan(
              text:
                  ' de Anowan.com. Nous utilisons les informations vous concernant comme indiqué dans notre '),
          TextSpan(
            text: 'Politique de confidentialité',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              color: Palette.appRed,
            ),
          ),
          TextSpan(text: ' et notre '),
          TextSpan(
            text: 'Politique relative aux témoins de connexion (cookies).',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              color: Palette.appRed,
            ),
          ),
        ],
      ),
    );
  }
}
