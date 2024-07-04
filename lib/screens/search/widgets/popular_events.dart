import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../model/event_model.dart';
import '../../../widgets/envent_card_column.dart';

Widget popularEvents({required Size size, required BuildContext context}) {
  List<EventModel> _pEvents = [
    EventModel.eventList[4],
    EventModel.eventList[0],
    EventModel.eventList[2]
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.small(
        "Populaire",
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _pEvents
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
  );
}
