import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../home/widgets/event_card.dart';

class MoreEventContainer extends StatelessWidget {
  const MoreEventContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 80),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            "Événements similaires",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(15),
          Column(
            children: List.generate(
              3,
              (index) => EventCard(index: index),
            ),
          )
        ],
      ),
    );
  }
}
