import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/full_screen_maps.dart';

import '../../../config/app_text.dart';
import '../../../constants/constants.dart';
import '../../../model/localization_model.dart';
import 'custom_map.dart';
import 'position_full_info.dart';

class GoogleMapContainer extends StatefulWidget {
  GoogleMapContainer({
    Key? key,
    required this.localization,
  }) : super(key: key);
  final LocalizationModel localization;

  @override
  State<GoogleMapContainer> createState() => _GoogleMapContainerState();
}

class _GoogleMapContainerState extends State<GoogleMapContainer> {
  GoogleMapsGeocoding geocoding = GoogleMapsGeocoding(apiKey: mapsApiKey);

  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setInitialPosition();
  }

  Future<void> _setInitialPosition() async {
    String? latitude = widget.localization.latitude;
    String? longitude = widget.localization.longitude;

    // Fonction pour mettre à jour la position initiale et les marqueurs
    void _updatePosition(double lat, double lng) {
      setState(() {
        _initialPosition = LatLng(lat, lng);
        _markers.add(
          Marker(
            markerId: MarkerId('initialPosition'),
            position: _initialPosition!,
            infoWindow: InfoWindow(title: widget.localization.place),
          ),
        );
      });
    }

    if ((latitude != null && longitude != null) &&
        (latitude.trim().isNotEmpty && longitude.trim().isNotEmpty)) {
      double? lat = double.tryParse(latitude);
      double? lng = double.tryParse(longitude);

      if (lat != null && lng != null) {
        _updatePosition(lat, lng);
      } else {
        print('Erreur lors de la conversion des coordonnées');
      }
    } else {
      try {
        print(
            'Recherche des coordonnées pour ----> ${widget.localization.place}');

        final geocodingResponse = await geocoding
            .searchByAddress(widget.localization.place, components: [
          Component('country', 'CI')
        ]); // CI pour Côte d'Ivoire);

        if (geocodingResponse.isOkay && geocodingResponse.results.isNotEmpty) {
          final location = geocodingResponse.results.first.geometry.location;
          _updatePosition(location.lat, location.lng);
        } else {
          print(
              'Erreur lors du géocodage de l\'adresse : ${geocodingResponse.errorMessage}');
        }
      } catch (e) {
        print('Erreur lors du géocodage de l\'adresse : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialPosition == null) {
      return Container();
    }
    List<String> icons = [
      'assets/icons/car.svg',
      'assets/icons/train.svg',
      'assets/icons/bicycle.svg',
      'assets/icons/person-walking.svg',
    ];
    return InkWell(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => FullScreenMaps(
            localization: widget.localization,
          ),
        ),
      ),
      splashColor: Colors.transparent,
      child: Padding(
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
                CustomMap(
                  initialPosition: _initialPosition!,
                  place: widget.localization.place,
                ),
                PositionFullInfo(
                  icons: icons,
                  location: _initialPosition!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
