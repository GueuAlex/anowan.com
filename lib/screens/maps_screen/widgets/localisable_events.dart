import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../model/event_model.dart';
import '../../../providers/providers.dart';
import '../../../widgets/event_card_row.dart';

class LocalisableEvents extends ConsumerStatefulWidget {
  const LocalisableEvents({super.key});

  @override
  ConsumerState<LocalisableEvents> createState() => _LocalisableEventsState();
}

class _LocalisableEventsState extends ConsumerState<LocalisableEvents> {
  @override
  Widget build(BuildContext context) {
    var events = ref.watch(eventsProvider);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: events.when(
        data: (events) {
          List<EventModel> list = Functions.filterAndSortUpcomingEvents(
            events: events,
          );
          return Row(
            children: List.generate(
              list.length,
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
                        color:
                            Color.fromARGB(255, 228, 227, 227).withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: EventCardRow(
                    event: list[index],
                    color: Colors.white,
                  ),
                );
              },
            ),
          );
        },
        error: (e, _) => Center(
          child: AppText.medium(
            e.toString(),
          ),
        ),
        loading: () => Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
