import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/full_screen_maps.dart';

import '../../../config/app_text.dart';
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
  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setInitialPosition();
  }

  Future<void> _setInitialPosition() async {
    if (widget.localization.longitude.trim().isNotEmpty == true &&
        widget.localization.latitude.trim().isNotEmpty == true) {
      setState(() {
        _initialPosition = LatLng(
          double.parse(widget.localization.latitude),
          double.parse(widget.localization.longitude),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('initialPosition'),
            position: _initialPosition!,
            infoWindow: InfoWindow(title: widget.localization.place),
          ),
        );
      });
    } else {
      try {
        List<Location> locations =
            await locationFromAddress(widget.localization.place);
        if (locations.isNotEmpty) {
          setState(() {
            _initialPosition =
                LatLng(locations.first.latitude, locations.first.longitude);
            _markers.add(
              Marker(
                markerId: MarkerId('initialPosition'),
                position: _initialPosition!,
                infoWindow: InfoWindow(title: widget.localization.place),
              ),
            );
          });
        }
      } catch (e) {
        // Gérer l'erreur de géocodage ici
        print('Erreur lors du géocodage de l\'adresse : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
