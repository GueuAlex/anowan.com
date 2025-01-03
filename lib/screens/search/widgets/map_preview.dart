import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../maps_screen/maps_screen.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({
    super.key,
  });

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late GoogleMapController mapController;

  final LatLng _initialPosition =
      LatLng(5.345317, -4.024429); // Coordonnées d'Abidjan
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addEventMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addEventMarkers() {
    // Ajoutez vos marqueurs d'événements ici
    _markers.add(
      Marker(
        markerId: MarkerId('event1'),
        position: LatLng(5.347017, -4.024429),
        onTap: () => _onMapTapped(LatLng(5.347017, -4.024429)),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('event2'),
        position: LatLng(5.348317, -4.026429),
        onTap: () => _onMapTapped(LatLng(5.348317, -4.026429)),
      ),
    );

    // Ajoutez plus de marqueurs si nécessaire
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.medium(
              'Évènements près de',
              fontSize: (size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
            TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () {},
              label: AppText.medium(
                'Abidjan',
                fontSize: (size.width * 0.040),
                fontWeight: FontWeight.w700,
                color: Palette.appRed,
              ),
              icon: Icon(
                FluentIcons.edit_20_regular,
                size: 16,
                color: Palette.appRed,
              ),
            ),
          ],
        ),

        // google maps
        Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  onTap: _onMapTapped,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 12.0,
                  ),
                  markers: _markers,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => _onMapTapped(LatLng(5.348317, -4.026429)),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.search_24_regular,
                        color: Palette.blackColor,
                        size: 18,
                      ),
                      AppText.medium(
                        'Afficher la carte',
                        color: Palette.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
      // google maps
    );
  }

  void _onMapTapped(LatLng argument) {
    print(argument);
    Navigator.of(context).pushNamed(MapsScreen.routeName, arguments: argument);
  }
}
