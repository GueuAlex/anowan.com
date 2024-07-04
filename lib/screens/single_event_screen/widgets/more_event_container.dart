import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/model/event_model.dart';

import '../../../config/app_text.dart';
import '../../../widgets/event_card_row.dart';

class MoreEventContainer extends StatelessWidget {
  const MoreEventContainer({
    super.key,
    required this.categoryId,
  });
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    // Filtrer les événements par categoryId
    //final List<EventModel> eventModels = EventModel.eventList.where((event) => event.categoryId == categoryId).toList();
    final List<EventModel> eventModels = EventModel.eventList;

    // Vérifier s'il y a des événements dans la catégorie donnée
    if (eventModels.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: AppText.medium(
          "Aucun événement similaire trouvé",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            "Événements similaires",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(15),
          Column(
            children: List.generate(
              eventModels.sublist(0, 3).length,
              (index) => EventCardRow(event: eventModels[index]),
            ),
          )
        ],
      ),
    );
  }
}
