import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/category_model.dart';
import '../../../model/event_model.dart';
import '../../../widgets/action_tile.dart';
import 'categories_container.dart';
import 'category_events.dart';
import 'discover_by_date.dart';
import 'map_preview.dart';
import 'popular_events.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key, required this.events});
  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    //final upcomingEvents = Functions.filterAndSortUpcomingEvents(events);
    //print(events.length > 7);
    bool isMoreThan7 = events.length > 7;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MapPreview(),
                Gap(15),
                DiscoversByDate(),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top:
                          BorderSide(width: 0.8, color: Palette.separatorColor),
                    ),
                  ),
                  child: actionTile(
                    size: size,
                    onTap: () {},
                    title: "Trouver un prestataire",
                    subtitle: "Pour l'organisation évènementiel",
                    asset: "assets/images/search-icon.png",
                  ),
                ),
                Gap(5)
              ],
            ),
          ),
          Gap(10),
          // Dsicover events
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: AppText.medium(
              'Découvrir des évenements',
              fontSize: (size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                popularEvents(
                  size: size,
                  context: context,
                  events: isMoreThan7 ? events.sublist(0, 6) : events,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: CategoryModel.categories
                      .map(
                        (category) => categoryEvents(
                          category: category.libelle,
                          size: size,
                          context: context,
                          events: events,
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),

          //become organizer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 0.8, color: Palette.separatorColor),
              ),
            ),
            child: actionTile(
                size: size,
                onTap: () {},
                title: "Dévenir organisateur",
                subtitle: "Organiser vos propres évènements",
                asset: "assets/images/cup.png"),
          ),

          // discover by categories
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 22, 26, 27),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(
                  'Parcourir les catégories',
                  color: const Color.fromARGB(255, 240, 240, 240),
                  fontSize: (size.width * 0.042),
                  fontWeight: FontWeight.w500,
                ),
                Gap(20),
                categoriesContainer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
