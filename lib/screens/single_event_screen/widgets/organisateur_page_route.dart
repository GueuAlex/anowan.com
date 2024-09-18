import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/model/organizer_model.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../constants/constants.dart';
import '../../organizer_screen/organizer_screen.dart';

class OrganisateurPageRoute extends StatelessWidget {
  const OrganisateurPageRoute({
    super.key,
    required this.organizer,
  });
  final OrganizerModel organizer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    'Organiser par',
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: const Color.fromARGB(255, 35, 41, 54),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      OrganizerScreen.routeName,
                      arguments: organizer,
                    ),
                    child: AppText.medium(
                      organizer.name,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  Gap(8),
                  Transform.rotate(
                    angle: -0.02,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Palette.appRed,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: AppText.medium(
                        '0 abonnés',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gap(15),
            // folow button
            /* ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(1),
                fixedSize: WidgetStatePropertyAll(Size(double.infinity, 0)),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15),
                ),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 17, 118, 234),
                ),
              ),
              onPressed: () {},
              child: AppText.medium(
                'Suivre',
                textAlign: TextAlign.center,
                color: Palette.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ), */

            Container(
              width: 70,
              height: 50,
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    organizer.avatar.trim().isNotEmpty
                        ? organizer.avatar
                        : networtImgPlaceholder,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
