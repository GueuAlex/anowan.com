import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    super.key,
    required this.initialPosition,
    required this.place,
  });

  final LatLng initialPosition;
  final String place;

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('initialPosition'),
        position: initialPosition,
        infoWindow: InfoWindow(title: place),
      ),
    };
    return Container(
      height: 250, // Hauteur de la carte
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GoogleMap(
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 12.0,
          ),
          markers: _markers,
        ),
      ),
    );
  }
}
