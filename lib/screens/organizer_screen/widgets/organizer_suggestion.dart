import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../providers/providers.dart';
import '../../../widgets/custom_button.dart';
import 'organizer_card.dart';

class OrganizerSuggestion extends ConsumerWidget {
  const OrganizerSuggestion({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizers = ref.watch(oragnizersProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Qui suivre',
          fontSize: (size.width * 0.042),
          fontWeight: FontWeight.w500,
        ),
        Gap(10),
        AppText.medium(
          'Suivez les organisateurs locaux les plus populaires et recevez des notifications lorsqu\'ils créent des événements.',
          fontSize: (size.width * 0.038),
          fontWeight: FontWeight.w300,
        ),
        Gap(25),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: organizers.when(
            data: (organizers) {
              return Row(
                children: organizers.map((organizer) {
                  if (organizer.avatar.trim().isEmpty) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: organizerCard(
                      size: size,
                      context: context,
                      organizer: organizer,
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) {
              // Affichage d'un message d'erreur avec un log optionnel de stackTrace
              debugPrint("Error loading organizers: $error");
              debugPrint("Stack trace: $stackTrace");

              return Column(
                children: [
                  const Text(
                    'Une erreur est survenue lors du chargement des organisateurs. Veuillez réessayer plus tard.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    color: Palette.appRed,
                    width: 150,
                    height: 35,
                    radius: 5,
                    text: 'Réessayer',
                    onPress: () => ref.refresh(oragnizersProvider),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
