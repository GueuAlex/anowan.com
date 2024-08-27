import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class GetContact extends StatelessWidget {
  const GetContact({
    super.key,
    required this.svgPah,
    required this.text,
    required this.onTap,
    this.gap = 2,
  });
  final String svgPah;
  final String text;
  final VoidCallback onTap;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPah,
              colorFilter: ColorFilter.mode(
                Palette.appRed,
                BlendMode.srcIn,
              ),
            ),
            Gap(gap),
            AppText.medium(
              text,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }
}
