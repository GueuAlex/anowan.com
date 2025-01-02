import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/action_tile.dart';

Container ticketsMissing({
  required Size size,
  String text =
      'Vous n\'avez pas de tickets à venir, consulter votre liste d\'évènements recommandés pour prendre un billet',
}) =>
    Container(
      width: double.infinity,
      //height: size.height * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              //color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/tickek-missing.png'),
          ),
          AppText.medium(
            text,
            textAlign: TextAlign.center,
            fontSize: size.width * 0.033,
            fontWeight: FontWeight.w300,
            color: const Color.fromARGB(255, 83, 83, 83),
          ),
          Gap(10),
          Container(
            width: double.infinity,
            // margin: const EdgeInsets.only(top: 25),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 0.8, color: Palette.separatorColor),
              ),
            ),
            child: actionTile(
              size: size,
              onTap: () {},
              title: "Évènements recommandés",
              subtitle: "Consulter votre liste d'évènements recommandés",
              asset: "assets/images/list.jpg",
            ),
          ),
        ],
      ),
    );
