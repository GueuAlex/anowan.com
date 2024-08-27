import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/palette.dart';
import '../../../model/organizer_model.dart';
import '../../../widgets/counter.dart';
import '../../../widgets/vertical_separator.dart';

class OrganizerHeader extends StatelessWidget {
  const OrganizerHeader({
    super.key,
    required this.organizer,
  });
  final OrganizerModel organizer;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.separatorColor,
              border: Border.all(
                width: 0.8,
                color: Palette.separatorColor,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/anowan-placeholder.png',
                image: organizer.avatar,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/anowan-placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
                width: double.infinity,
                //height: size.width * 0.25,
              ),
            ),
          ),
          Gap(5),
          Expanded(
            child: Row(
              children: [
                counter(count: 180, text: 'évents Organisés', fontSize: 22),
                verticalSeparator(),
                counter(count: 990, text: 'followers', fontSize: 22),
                verticalSeparator(),
                counter(count: 45, text: 'évents à venir', fontSize: 22),
              ],
            ),
          )
        ],
      ),
    );
  }
}
