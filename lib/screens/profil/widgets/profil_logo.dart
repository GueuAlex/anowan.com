import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../user_details_screen/user_details_screen.dart';

Container profilLogo({required BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    //padding: const EdgeInsets.all(3),
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Palette.primaryColor.withOpacity(0.3),
      border: Border.all(
        width: 2,
        color: Palette.primaryColor.withOpacity(0.6),
      ),
    ),
    child: InkWell(
      onTap: () => Navigator.of(context).pushNamed(UserDetailsScreen.routeName),
      child: Center(
        child: AppText.large(
          'G',
          fontSize: 21.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
