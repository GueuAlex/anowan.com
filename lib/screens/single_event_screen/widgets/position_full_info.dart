import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_text.dart';

class PositionFullInfo extends StatelessWidget {
  const PositionFullInfo({
    super.key,
    required this.icons,
    required this.location,
  });

  final List<String> icons;
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return FutureBuilder<List<Placemark>>(
      future: placemarkFromCoordinates(location.latitude, location.longitude,
          localeIdentifier: 'en'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune donnée de lieu disponible'));
        }
        final placemark = snapshot.data![0];
        final place = '${placemark.name}';
        final address = '  ${placemark.locality}';

        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.9),
            ),
            child: Column(
              children: [
                AppText.medium(
                  address,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                Gap(8),
                AppText.medium(
                  place,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    icons.length,
                    (index) => Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800.withOpacity(
                          0.15,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SvgPicture.asset(icons[index]),
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      //child:
    );
  }
}
