import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import 'tag_wiget.dart';

class TageContainer extends StatelessWidget {
  const TageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tags = [
      'education',
      'voyage',
      'cuisine',
      'sport',
      'design workshop',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'Lié à cet événement',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(15),
          TagWidget(tags: tags)
        ],
      ),
    );
  }
}
