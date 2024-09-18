import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../model/event_model.dart';
import '../../../widgets/envent_card_column.dart';

Widget popularEvents(
    {required Size size,
    required BuildContext context,
    required List<EventModel> events}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.medium(
        "Populaire",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: events.map(
            (event) {
              //print(event.id);
              return eventCardColumn(
                event: event,
                size: size,
                context: context,
              );
            },
          ).toList(),
        ),
      ),
    ],
  );
}
