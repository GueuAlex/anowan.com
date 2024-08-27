import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/alert_1.dart';

class SellStatus extends StatelessWidget {
  const SellStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: recentAdd(),
    );
  }

  Container recentAdd() {
    return Container(
      width: double.infinity,
      height: 45,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 104, 175, 168).withOpacity(0.15),
                borderRadius: BorderRadius.circular(3),
              ),
              child: AppText.medium(
                'Ajouté récemment !',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 17, 85, 78),
              ),
            ),
            Gap(10),
            Alert1(
              alert: 'Les ventes de billets se terminent bientôt !',
              color: Colors.red,
              icon: CupertinoIcons.exclamationmark_triangle,
            ),
          ],
        ),
      ),
    );
  }

  Container soldOut() {
    return Container(
      // lorsque l'evenement est gratuit
      decoration: BoxDecoration(
        color: Color.fromARGB(138, 255, 219, 17),
        //border: Border.all(width: 1, color: Palette.primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            FluentIcons.megaphone_24_regular,
            color: Palette.blackColor,
          ),
          Gap(15),
          Expanded(
            child: Container(
              child: AppText.medium(
                'Ventes terminées',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Palette.blackColor.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container freeBadget() {
    return Container(
      // lorsque l'evenement est gratuit
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.1),
        border: Border.all(width: 1, color: Palette.primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            Icons.money_off_csred,
            color: Palette.primaryColor,
          ),
          Gap(5),
          Expanded(
            child: Container(
              child: AppText.medium(
                'Gratuit',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.primaryColor,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/free.svg',
            height: 30,
            width: 30,
          )
        ],
      ),
    );
  }
}
