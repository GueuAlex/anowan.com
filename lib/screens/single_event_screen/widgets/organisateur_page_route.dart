import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class OrganisateurPageRoute extends StatelessWidget {
  const OrganisateurPageRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
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
                  InkWell(
                    onTap: () => print('go to orgasiteur profil'),
                    child: AppText.medium(
                      'Captain Shrine - La Maison du Rhum',
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gap(8),
                  AppText.medium(
                    '59 abonnés',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  )
                ],
              ),
            ),
            Gap(15),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(1),
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(255, 17, 118, 234),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                width: 90,
                child: AppText.medium(
                  'Suivre',
                  textAlign: TextAlign.center,
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
