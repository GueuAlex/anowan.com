import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/model/organizer_model.dart';
import 'package:ticketwave/screens/organizer_screen/organizer_screen.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Container organizerCard({
  required Size size,
  required BuildContext context,
  required OrganizerModel organizer,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      width: size.width * 0.45,
      //height: size.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0.8,
          color: Palette.separatorColor,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          OrganizerScreen.routeName,
          arguments: organizer,
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
                        organizer.avatar,
                      ),
                    ),
                  ),
                ),
                Gap(5),
                // organizer name
                AppText.medium(
                  organizer.name,
                  maxLine: 1,
                  textAlign: TextAlign.center,
                  fontSize: (size.width * 0.045),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Gap(10),
            // follow button
            Container(
              // height: size.height * 0.055,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.8,
                  color: Palette.primaryColor.withOpacity(0.5),
                ),
                color: Palette.primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () => print("Follw process"),
                child: Center(
                  child: AppText.medium(
                    'Suivre',
                    fontSize: 16,
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
