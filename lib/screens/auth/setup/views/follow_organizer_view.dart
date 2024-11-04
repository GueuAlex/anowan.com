import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';

import '../../../../config/app_text.dart';
import '../../../../constants/constants.dart';
import '../../../../providers/providers.dart';
import '../../../organizer_screen/widgets/organizer_row.dart';

class FollowOrganizerView extends ConsumerStatefulWidget {
  const FollowOrganizerView({super.key});

  @override
  _FollowOrganizerViewState createState() => _FollowOrganizerViewState();
}

class _FollowOrganizerViewState extends ConsumerState<FollowOrganizerView> {
  @override
  Widget build(BuildContext context) {
    // Consommer les données du provider
    final organizersAsyncValue = ref.watch(oragnizersProvider);
    // place
    final selectedPlace = ref.read(selectedPlaceProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.large(
              'Qui suivre ?',
              textAlign: TextAlign.left,
            ),
            const Gap(3),
            AppText.medium(
              'Suivez les organisateurs locaux les plus populaires et recevez des notifications lorsqu\'ils créent des évènements.',
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

            // Gestion de l'état des organisateurs via Riverpod
            organizersAsyncValue.when(
              data: (organizers) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: organizers.length,
                  itemBuilder: (context, index) {
                    final organizer = organizers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: !organizer.avatar!.trim().isEmpty
                          ? OrganizerRow(
                              assets: organizer.avatar ??
                                  networtImgPlaceholder, // Assuming imageUrl in OrganizerModel
                              name: organizer.name ?? '',
                              followers: '114k followers',
                              events: '9+ événements',
                              isSetup: true,
                              organizerId: organizer.id.toString(),
                            )
                          : Container(),
                    );
                  },
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Erreur de chargement des organisateurs'),
              ),
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
