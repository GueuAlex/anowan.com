import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../model/event_model.dart';
import '../../../widgets/envent_card_column.dart';

Widget categoryEvents({
  required String category,
  required Size size,
  required BuildContext context,
  required List<EventModel> events,
}) {
  final List<EventModel> _event =
      Functions.filterEventsByCategory(events, category);

  if (_event.isEmpty) {
    return Container();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.medium(
        category,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      //AppText.small(_),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _event.map(
            (event) {
              if (event.category.toLowerCase().trim() ==
                  category.toLowerCase().trim()) {}
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
