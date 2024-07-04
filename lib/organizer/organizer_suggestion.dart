import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';
import 'widgets/organizer_card.dart';

class OrganizerSuggestion extends StatefulWidget {
  const OrganizerSuggestion({
    super.key,
  });

  @override
  State<OrganizerSuggestion> createState() => _OrganizerSuggestionState();
}

class _OrganizerSuggestionState extends State<OrganizerSuggestion> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Qui suivre',
          fontSize: (size.width * 0.042),
          fontWeight: FontWeight.w500,
        ),
        Gap(10),
        AppText.medium(
          'Suivez les organisateurs locaux les plus populaires et recevez des notifications lorsqu\'ils créent des événements.',
          fontSize: (size.width * 0.038),
          fontWeight: FontWeight.w300,
        ),
        Gap(25),
        Row(
          children: [organizerCard(size: size)],
        )
      ],
    );
  }
}
