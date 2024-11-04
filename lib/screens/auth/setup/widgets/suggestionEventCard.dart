import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_text.dart';
import '../../../../config/palette.dart';
import '../../../../constants/constants.dart';
import '../../../../model/event_model.dart';
import '../../../../providers/bookmark_event_provider.dart';

class SuggestionEventCard extends ConsumerWidget {
  final EventModel event;
  final VoidCallback onTap;
  final Size size;

  const SuggestionEventCard({
    Key? key,
    required this.event,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer la liste des événements favoris
    final bookmarkedEvents = ref.watch(bookmarkedEventsProvider);

    // Vérifier si l'événement est déjà favori
    final bool isBookmarked = bookmarkedEvents.contains(event.id.toString());

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Palette.separatorColor,
          ),
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        onTap: onTap,
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            '${DateFormat('EEE MMM dd', 'fr_FR').format(
                              event.localizations[0].dateEvent,
                            )} \u2022 ${event.localizations[0].starttimeEvent} GMT+00:00',
                            fontSize: (size.width * 0.033),
                            color: Palette.appRed,
                            maxLine: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          Gap(2),
                          AppText.medium(
                            event.name,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: (size.width * 0.04),
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                            color: const Color.fromARGB(255, 39, 40, 41),
                          ),
                        ],
                      ),
                    ),
                    Gap(5),
                    Container(
                      constraints: BoxConstraints(maxWidth: 100, maxHeight: 50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/anowan-placeholder.png',
                          image: event.image ?? networtImgPlaceholder,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/anowan-placeholder.png',
                              fit: BoxFit.cover,
                            );
                          },
                          width: double.infinity,
                          height: size.height,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Palette.primaryColor,
                    ),
                    Gap(8),
                    Expanded(
                      child: AppText.small(
                        event.localizations[0].place ?? '',
                        textOverflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        color: const Color.fromARGB(255, 107, 120, 122),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isBookmarked ? Colors.grey : Palette.appRed,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (isBookmarked) return;
                          await ref
                              .read(bookmarkedEventsProvider.notifier)
                              .addEvent(event.id.toString());
                        },
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        child: const Text(
                          'Participer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
