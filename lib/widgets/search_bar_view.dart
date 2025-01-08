import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_text.dart';
import '../config/palette.dart';
import '../providers/providers.dart'; // Importez votre provider ici.

class SearchBarView extends ConsumerWidget {
  final String hintText;

  const SearchBarView({
    Key? key,
    this.hintText = 'Découvrez les évènements à venir',
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsyncValue = ref.watch(eventsProvider);

    return SearchAnchor.bar(
      viewLeading: Icon(
        FluentIcons.search_12_regular,
        color: Colors.grey.shade500,
        size: 22,
      ),
      viewTrailing: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text('Annuler'),
        )
      ],
      barHintText: hintText,
      isFullScreen: true,
      barLeading: Icon(
        FluentIcons.search_12_regular,
        color: Colors.grey.shade500,
        size: 22,
      ),
      barBackgroundColor: WidgetStatePropertyAll(
        Palette.primaryColor.withOpacity(0.1),
      ),
      barElevation: WidgetStatePropertyAll(0),
      barShape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      viewBackgroundColor: Colors.white,
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final String query = controller.text.toLowerCase();

        if (query.isEmpty) {
          return const [];
        }

        return eventsAsyncValue.when(
          data: (events) {
            final filteredEvents = events.where((event) {
              return event.name.toLowerCase().contains(query);
            }).toList();

            if (filteredEvents.isEmpty) {
              return [
                ListTile(
                  title: AppText.medium(
                    'Aucun événement trouvé.',
                    color: Colors.grey.shade500,
                  ),
                )
              ];
            }

            return filteredEvents.map((event) {
              return ListTile(
                title: AppText.medium(
                  event.name,
                  color: Colors.black,
                ),
                onTap: () {
                  // Action lorsque l'utilisateur clique sur un événement
                  print('Selected event: ${event.name}');
                },
              );
            });
          },
          loading: () => [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
          error: (error, stack) => [
            ListTile(
              title: AppText.medium(
                'Erreur lors du chargement des événements.',
                color: Colors.red,
              ),
            )
          ],
        );
      },
    );
  }
}
