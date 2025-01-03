import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../model/event_model.dart';
import '../../../providers/providers.dart';
import '../../../widgets/action_tile.dart';
import 'draggable_event_card.dart';

class InfiniEventsList extends ConsumerStatefulWidget {
  const InfiniEventsList({super.key});

  @override
  ConsumerState<InfiniEventsList> createState() => _InfiniEventsListState();
}

class _InfiniEventsListState extends ConsumerState<InfiniEventsList> {
  List<EventModel> displayedEvents = [];
  int currentPage = 0;
  bool isLoadingMore = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    // Charger la première page d'événements
    _loadMoreEvents();
  }

  Future<void> _loadMoreEvents() async {
    if (isLoadingMore || !hasMore) return;
    setState(() {
      isLoadingMore = true;
    });

    // Simuler un appel à l'API avec un délai
    //await Future.delayed(Duration(seconds: 2), () {
    var events = ref.read(eventsProvider);
    List<EventModel> list = Functions.filterAndSortUpcomingEvents(
      events: events.value ?? [],
    );
    setState(() {
      int nextPage = currentPage + 1;
      List<EventModel> newEvents =
          list.skip(currentPage * 10).take(10).toList();
      if (newEvents.isEmpty) {
        hasMore = false;
      } else {
        displayedEvents.addAll(newEvents);
        currentPage = nextPage;
      }
      isLoadingMore = false;
    });
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: displayedEvents.isEmpty && !isLoadingMore
              ? Center(child: AppText.small('pas d\'événement pour le moment'))
              : ListView.builder(
                  itemCount: displayedEvents.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < displayedEvents.length) {
                      //return draggableEventCard(event: displayedEvents[index]);
                      if (index == 2) {
                        return Column(
                          children: [
                            draggableEventCard(event: displayedEvents[index]),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                top: 10,
                              ),
                              child: actionTile(
                                  size: MediaQuery.of(context).size,
                                  onTap: () {},
                                  title: "Dévenir organisateur",
                                  subtitle: "Organiser vos propres évènements",
                                  asset: "assets/images/cup.png"),
                            ), // Votre widget publicitaire
                          ],
                        );
                      } else {
                        return draggableEventCard(
                            event: displayedEvents[index]);
                      }
                    } else {
                      // Utiliser addPostFrameCallback pour différer l'appel de _loadMoreEvents()
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _loadMoreEvents();
                      });
                      return Center(child: AppText.small('Chargement...'));
                    }
                  },
                ),
        ),
        if (isLoadingMore && hasMore)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText.small('Chargement...'),
          ),
      ],
    );
  }
}
