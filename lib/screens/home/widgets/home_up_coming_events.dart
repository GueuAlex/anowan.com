import 'package:flutter/material.dart';
import 'package:ticketwave/model/event_model.dart';
import 'package:ticketwave/widgets/envent_card_column.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class HomeUpcomingEvents extends StatelessWidget {
  const HomeUpcomingEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.medium(
                'Évènements à venir',
                fontSize: (size.width * 0.042),
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                iconAlignment: IconAlignment.end,
                onPressed: () {},
                child: AppText.medium(
                  'Voir tout',
                  fontSize: (size.width * 0.040),
                  fontWeight: FontWeight.w700,
                  color: Palette.appRed,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: EventModel.eventList
                  .map(
                    (event) => eventCardColumn(
                      event: event,
                      size: size,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
