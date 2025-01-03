import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../model/event_model.dart';
import '../../../../providers/providers.dart';
import '../widgets/show_event_detail_sheet.dart';
import '../widgets/suggestionEventCard.dart';

class EventSuggestion extends ConsumerStatefulWidget {
  const EventSuggestion({super.key});

  @override
  _EventSuggestionState createState() => _EventSuggestionState();
}

class _EventSuggestionState extends ConsumerState<EventSuggestion> {
  @override
  Widget build(BuildContext context) {
    final eventsAsyncValue = ref.watch(eventsProvider);
    // place
    final selectedPlace = ref.read(selectedPlaceProvider);
    // events
    //final bookmarkedEvents = ref.watch(bookmarkedEventsProvider);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.large(
              'Inscrivez-vous aux prochains évènements',
              textAlign: TextAlign.left,
            ),
            const Gap(3),
            AppText.medium(
              'Vous pouvez modifier vos inscriptions à tout moment.',
              fontWeight: FontWeight.w300,
              fontSize: 15,
              textAlign: TextAlign.left,
            ),
            const Gap(10),
            RichText(
              text: TextSpan(
                text: 'À proximité de ',
                children: [
                  TextSpan(
                    text:
                        Functions.getFirstWord(selectedPlace) ?? 'Abidjan - CI',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Palette.appRed,
                    ),
                  )
                ],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Gap(20),
            // Consommation des événements
            eventsAsyncValue.when(
              data: (events) {
                List<EventModel> filteredEvents =
                    Functions.filterAndSortUpcomingEvents(
                  events: events,
                  withPassEvents: false,
                );
                return Column(
                  children: filteredEvents.map((event) {
                    // Détermine si cet organisateur est déjà suivi
                    //final isBookmarked = bookmarkedEvents.contains(event.id);
                    return SuggestionEventCard(
                      event: event,
                      size: size,
                      onTap: () => Functions.showSimpleBottomSheet(
                        ctxt: context,
                        widget: ShowEventDetailSheet(
                          event: event,
                        ),
                      ),
                    ); // Ici, chaque événement est passé à EventCardRow
                  }).toList(),
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (err, stack) => Center(
                child: Text('Erreur: $err'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
