import 'package:flutter/material.dart';
import 'package:ticketwave/screens/suggestion_screen/suggestion_screen.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Container suggestions({required Size size, required BuildContext context}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    padding: const EdgeInsets.all(10),
    height: 190,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: AppText.medium(
            'Obtenir des suggestions d\'événements',
            fontSize: size.width * 0.040,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3, bottom: 10),
          child: AppText.small(
            'Vous avez ${19} suggestions d\'événements à venir',
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w300,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          decoration: BoxDecoration(
            color: Palette.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, SuggestionScreen.routeName),
            child: AppText.medium(
              'Afficher les suggestions d\'évènements',
              fontSize: size.width * 0.040,
              textAlign: TextAlign.center,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    ),
  );
}
