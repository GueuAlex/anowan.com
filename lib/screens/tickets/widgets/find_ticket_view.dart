import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Container findTicketView({required Size size}) => Container(
      width: double.infinity,
      //height: size.height * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            //padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              //color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/tickets-not-found.png'),
          ),
          AppText.medium(
            'Vous ne voyez pas vos billets ? En savoir plus comment les retrouver',
            textAlign: TextAlign.center,
            fontSize: size.width * 0.033,
            fontWeight: FontWeight.w300,
            color: const Color.fromARGB(255, 83, 83, 83),
          ),
          Gap(15),
          TextButton.icon(
            iconAlignment: IconAlignment.end,
            onPressed: () {},
            label: AppText.medium(
              'Trouver mes billets',
              fontSize: size.width * 0.038,
              fontWeight: FontWeight.w500,
              color: Palette.appRed,
            ),
            icon: SvgPicture.asset(
              'assets/icons/fleche-vers-le-haut-vers-la-droite.svg',
              // ignore: deprecated_member_use
              color: Palette.appRed,
              width: 16,
              //size: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
