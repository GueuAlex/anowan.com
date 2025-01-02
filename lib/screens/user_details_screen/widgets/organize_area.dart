import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../organizer_screen/widgets/organizer_row.dart';

class OrganizeArea extends StatelessWidget {
  const OrganizeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large(
            'Organisateur',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          AppText.medium(
            'Les organisateurs que vous suivez apparaissent ici',
            fontSize: 14,
            color: Colors.black54,
          ),
          const Gap(10),
          OrganizerRow(
            assets: 'assets/images/lunch.jpg',
            name: 'Noblesse Sweetness & Food',
            followers: '45k',
            events: '+99 événements',
            organizerId: '1',
          ),
          Gap(8),
          OrganizerRow(
            assets: 'assets/images/expert.jpeg',
            name: 'Expert consultant',
            followers: '250k',
            events: '47 événements',
            organizerId: '2',
          ),
          Gap(8),
          _beOrganizerRow(),
        ],
      ),
    );
  }

  Row _beOrganizerRow() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Palette.separatorColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.plus,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
        Gap(8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.medium(
                'Devenir organisateur',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              AppText.small(
                'Organisez vos propres événements dès maintenant',
                fontWeight: FontWeight.w300,
              ),
              Gap(5),
            ],
          ),
        ),
        Icon(
          CupertinoIcons.chevron_right,
          color: Colors.black54,
          size: 16,
        )
      ],
    );
  }
}
