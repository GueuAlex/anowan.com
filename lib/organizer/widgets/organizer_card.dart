import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';

Container organizerCard({required Size size}) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: size.width * 0.50,
      //height: size.height * 0.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0.8,
          color: Palette.separatorColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // organizer logo
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(24, 104, 125, 175),
                  border: Border.all(
                    width: 0.1,
                    color: Palette.primaryColor,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://anowan.com/organizers/images/pastorale-pour-la-propagation-de-levangile-2024-05-20-093152.jpg',
                    ),
                  ),
                ),
              ),
              Gap(5),
              // organizer name
              AppText.medium(
                'Pastorale pour la Propagation de l\'Evangile',
                maxLine: 2,
                textAlign: TextAlign.center,
                fontSize: (size.width * 0.045),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(25),
          // follow button
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 3),
            child: Container(
                height: size.height * 0.055,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.50,
                    color: Palette.primaryColor,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    elevation: WidgetStatePropertyAll(0.00),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  onPressed: Functions.followOrganizer,
                  child: Center(
                    child: AppText.medium(
                      'Suivre',
                      color: Palette.primaryColor,
                      fontSize: (size.width * 0.038),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
