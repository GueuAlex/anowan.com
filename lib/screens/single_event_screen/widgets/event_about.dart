import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';

class EventAbout extends StatelessWidget {
  const EventAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'A propos de cet événement',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(12),
          AppText.medium(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy,',
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          Gap(8),
          InkWell(
            onTap: () => print('go to full description'),
            child: AppText.medium(
              'En savoir plus',
              color: Color.fromARGB(255, 25, 74, 190),
            ),
          )
        ],
      ),
    );
  }
}
