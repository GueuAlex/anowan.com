import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/widgets/vertical_separator.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _rateButton(onTap: () {}),
              Gap(8),
              _button(onTap: () {}),
              Gap(8),
              _button(onTap: () {}, isShare: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rateButton({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.14),
          borderRadius: BorderRadius.circular(3.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.medium(
              '4.5 ',
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            Gap(3),
            SvgPicture.asset(
              'assets/icons/star.svg',
              width: 16,
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 227, 175, 16), BlendMode.srcIn),
            ),
            verticalSeparator(height: 10),
            AppText.medium(
              'nous noté',
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }

  Widget _button({required VoidCallback onTap, bool isShare = true}) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.14),
          borderRadius: BorderRadius.circular(3.5),
        ),
        child: !isShare
            ? SvgPicture.asset(
                'assets/icons/a.svg',
                width: 20,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 9, 9, 9), BlendMode.srcIn),
              )
            : AppText.medium(
                'Partager ce profile',
                fontWeight: FontWeight.w700,
              ),
      ),
    );
  }
}
