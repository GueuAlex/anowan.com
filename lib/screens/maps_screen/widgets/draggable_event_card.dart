import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

import '../../../model/event_model.dart';
import '../../../widgets/event_card_row.dart';

Container draggableEventCard({required EventModel event}) {
  return Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.only(
        //top: 10,
        //right: 8,
        //left: 8,
        ),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(0),
        border: Border(
          bottom: BorderSide(
            color: Palette.separatorColor,
            width: 0.8,
          ),
        )),
    child: EventCardRow(
      event: event,
      color: Colors.white,
    ),
  );
}
