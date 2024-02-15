import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';

import '../../../config/app_text.dart';
import 'custom_map.dart';
import 'position_full_info.dart';

class GoogleMapContainer extends StatelessWidget {
  GoogleMapContainer({
    Key? key,
  }) : super(key: key);

  // L'adresse que vous souhaitez afficher sur la carte
  final LatLng location =
      LatLng(37.7749, -122.4194); // Coordonnées de San Francisco

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      'assets/icons/car.svg',
      'assets/icons/train.svg',
      'assets/icons/bicycle.svg',
      'assets/icons/person-walking.svg',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'Lieu',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(15),
          Stack(
            children: [
              CustomMap(location: location),
              PositionFullInfo(
                icons: icons,
                location: location,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
