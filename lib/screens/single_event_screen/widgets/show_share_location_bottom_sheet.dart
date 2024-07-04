import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/icon_row.dart';

import '../../../config/app_text.dart';
import '../../../model/localization_model.dart';
import 'full_screen_maps.dart';

class ShowShareLocationBottomSheet extends StatelessWidget {
  const ShowShareLocationBottomSheet({
    super.key,
    required this.localization,
    //required this.event,
  });
  final LocalizationModel localization;
  // final EventModel event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                AppText.medium(
                  '',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: Color.fromARGB(255, 20, 20, 20),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(35),
            //écrir une phrase attrayante et accrocheur
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  IconRow(
                    icon: CupertinoIcons.share,
                    title: 'Partager la localisation',
                    subtitle: 'Faites savoir à vos amis où vous serez',
                    onTap: () {
                      // Action de partage de la localisation
                    },
                  ),
                  Gap(10),
                  IconRow(
                    icon: Icons.location_on,
                    title: 'Afficher sur la carte',
                    subtitle: 'Découvrez le lieu en un coup d\'œil',
                    onTap: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => FullScreenMaps(
                          localization: localization,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
