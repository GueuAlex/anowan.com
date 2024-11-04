import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../providers/providers.dart';
import '../../organizer_screen/widgets/organizer_card.dart';

class TopOrganizer extends ConsumerWidget {
  const TopOrganizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final organizers = ref.watch(oragnizersProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(25),
          AppText.medium(
            'Top organisateurs',
            fontSize: (size.width * 0.042),
            fontWeight: FontWeight.w500,
          ),
          Gap(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: organizers.when(
              data: (organizers) {
                return Row(
                  children: organizers.map((organizer) {
                    if (organizer.avatar!.trim().isEmpty) {
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
              loading: () => SizedBox(
                width: size.width,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
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
          Gap(25),
        ],
      ),
    );
  }
}
