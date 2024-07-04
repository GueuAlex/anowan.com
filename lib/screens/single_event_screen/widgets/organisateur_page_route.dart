import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class OrganisateurPageRoute extends StatelessWidget {
  const OrganisateurPageRoute({
    super.key,
  });
  //final Organi

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
                    onTap: () => print('go to orgasiteur profil'),
                    child: AppText.medium(
                      'Captain Shrine - La Maison du Rhum',
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
                        '59 abonnés',
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
                      "https://anowan.com/organizers/images/pastorale-pour-la-propagation-de-levangile-2024-05-20-093152.jpg"),
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
