import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class SideBarHeader extends StatelessWidget {
  const SideBarHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.elliptical(200, 10),
          bottomLeft: Radius.elliptical(200, 10),
        ),
      ),
      child: Row(
        children: [
          Container(
            //margin: const EdgeInsets.only(left: 5.0),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                width: 3,
                color: Palette.secondaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: /* Image.asset(
                'assets/images/black-woman.png',
                fit: BoxFit.cover,
              ), */
                    Placeholder()),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                AppText.medium('Nom du contrôleur'),
                FittedBox(
                  child: AppText.large(
                    'M2063LG4K',
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    //textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                AppText.small(
                  'Agent contrôleur \u2022 Agility \u2022 2015',
                  fontSize: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
