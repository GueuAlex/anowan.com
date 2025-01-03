import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/event_model.dart';
import '../../../widgets/envent_card_column.dart';
import '../../maps_screen/maps_screen.dart';

class HomeUpcomingEvents extends StatelessWidget {
  const HomeUpcomingEvents({
    super.key,
    required this.evenst,
  });

  final List<EventModel> evenst;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.medium(
                'Évènements à venir',
                fontSize: (size.width * 0.042),
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                iconAlignment: IconAlignment.end,
                onPressed: () => Navigator.pushNamed(
                  context,
                  MapsScreen.routeName,
                  arguments: LatLng(5.345317, -4.024429),
                ),
                child: AppText.medium(
                  'Voir tout',
                  fontSize: (size.width * 0.040),
                  fontWeight: FontWeight.w700,
                  color: Palette.appRed,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: evenst
                  .map(
                    (event) => eventCardColumn(
                      event: event,
                      size: size,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
