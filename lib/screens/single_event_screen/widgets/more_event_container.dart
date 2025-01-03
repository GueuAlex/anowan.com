import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../providers/providers.dart';
import '../../../widgets/event_card_row.dart';

class MoreEventContainer extends ConsumerWidget {
  const MoreEventContainer({
    super.key,
    required this.categoryId,
    required this.currentEventId,
  });
  final int categoryId;
  final int currentEventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);

    return events.when(
      data: (e) {
        final allEvents = Functions.filterAndSortUpcomingEvents(events: e);

        // Filter events based on categoryId and currentEventId
        final filteredEvents = allEvents
            .where((event) =>
                /* event.categoryId == categoryId && */ event.id !=
                currentEventId)
            .toList();

        final String title = filteredEvents.isEmpty
            ? "Événements populaire"
            : "Événements similaires";

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                title,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Gap(15),
              Column(
                children: filteredEvents.isEmpty
                    ? List.generate(
                        math.min(3, allEvents.length),
                        (index) => EventCardRow(event: allEvents[index]),
                      )
                    : List.generate(
                        math.min(3, filteredEvents.length),
                        (index) => EventCardRow(event: filteredEvents[index]),
                      ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return CircularProgressIndicator.adaptive();
      },
    );
  }
}
