import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../model/event_model.dart';
import '../../../widgets/event_card_row.dart';

class UpComingEvents extends StatelessWidget {
  const UpComingEvents({
    super.key,
    required this.events,
  });
  final List<EventModel> events;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: events.isNotEmpty
          ? Column(
              children: events.map((event) {
                return EventCardRow(
                  event: event,
                );
              }).toList(),
            )
          : Center(
              child: Column(
                children: [
                  Gap(70),
                  Image.asset(
                    'assets/images/calendar-crying.jpg',
                    width: 200,
                    height: 200,
                  ),
                  AppText.medium(
                    'Oops',
                    fontSize: 18,
                  ),
                  AppText.small(
                    'Rien à voir ici pour le moment',
                    fontSize: 14,
                  ),
                ],
              ),
            ),
    );
  }
}
