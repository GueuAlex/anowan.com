import 'package:flutter/material.dart';

import '../../../model/event_model.dart';
import '../../../widgets/event_card_row.dart';

class LocalisableEvents extends StatefulWidget {
  const LocalisableEvents({super.key});

  @override
  State<LocalisableEvents> createState() => _LocalisableEventsState();
}

class _LocalisableEventsState extends State<LocalisableEvents> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          EventModel.eventList.length,
          (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.only(
                top: 10,
                right: 8,
                left: 8,
              ),
              width: size.width - 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 88, 88, 88).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 228, 227, 227).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: EventCardRow(
                event: EventModel.eventList[index],
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
