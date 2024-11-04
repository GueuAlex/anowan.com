/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

Row organizerRow({
  required String name,
  required String followers,
  required String events,
  required String assets, // Ici, 'assets' est l'URL de l'image
  bool isSetup = false,
}) {
  return Row(
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Palette.separatorColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            placeholder:
                'assets/images/anowan-placeholder.png', // Image de remplacement pendant le chargement
            image: assets, // L'URL de l'image
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              // En cas d'erreur lors du chargement de l'image
              return Container(
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
      Gap(8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium(
              name,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              maxLine: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            AppText.small(
              '$followers followers \u2022 $events',
              fontWeight: FontWeight.w300,
            ),
            Gap(5),
          ],
        ),
      ),
      !isSetup
          ? Icon(
              CupertinoIcons.chevron_right,
              color: Colors.black54,
              size: 16,
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: Palette.appRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Suivre',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
    ],
  );
} */

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../providers/following_provider.dart';

class OrganizerRow extends ConsumerWidget {
  final String name;
  final String followers;
  final String events;
  final String assets; // URL de l'image
  final String organizerId;
  final bool isSetup;

  const OrganizerRow({
    required this.name,
    required this.followers,
    required this.events,
    required this.assets,
    required this.organizerId,
    this.isSetup = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupère la liste des organisateurs suivis
    final bookmarkedOrganizers = ref.watch(bookmarkedOrganizersProvider);
    //bookmarkedOrganizers.lo

    // Détermine si cet organisateur est déjà suivi
    final isFollowed = bookmarkedOrganizers.contains(organizerId);

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Palette.separatorColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage.assetNetwork(
              placeholder:
                  'assets/images/anowan-placeholder.png', // Image de remplacement pendant le chargement
              image: assets, // L'URL de l'image
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                // En cas d'erreur lors du chargement de l'image
                return Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        Gap(8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                name,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                maxLine: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
              AppText.small(
                '$followers followers \u2022 $events',
                fontWeight: FontWeight.w300,
              ),
              Gap(5),
            ],
          ),
        ),
        if (isSetup)
          GestureDetector(
            onTap: () async {
              // Ajoute l'organisateur aux favoris via le provider
              if (isFollowed) return;
              await ref
                  .read(bookmarkedOrganizersProvider.notifier)
                  .addOrganizer(organizerId);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: isFollowed ? Colors.grey : Palette.appRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  isFollowed ? 'Suivi' : 'Suivre',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        else
          Icon(
            CupertinoIcons.chevron_right,
            color: Colors.black54,
            size: 16,
          ),
      ],
    );
  }
}
