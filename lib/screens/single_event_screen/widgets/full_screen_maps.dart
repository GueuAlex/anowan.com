import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketwave/config/palette.dart';

import '../../../model/event_model.dart';
import '../../../model/localization_model.dart';
import '../../../widgets/event_card_row.dart';

class FullScreenMaps extends StatefulWidget {
  final LocalizationModel localization;

  const FullScreenMaps({
    super.key,
    required this.localization,
  });

  @override
  State<FullScreenMaps> createState() => _FullScreenMapsState();
}

class _FullScreenMapsState extends State<FullScreenMaps> {
  //late GoogleMapController _mapController;
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
        List<Location> locations =
            await locationFromAddress(widget.localization.place);
        if (locations.isNotEmpty) {
          _updatePosition(locations.first.latitude, locations.first.longitude);
        }
      } catch (e) {
        print('Erreur lors du géocodage de l\'adresse : $e');
      }
    }
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _initialPosition == null
          ? SizedBox(
              height: size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SafeArea(
                    child: Icon(
                      CupertinoIcons.back,
                      size: 18,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Container()
                ],
              ),
            )
          : Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height,
                  child: GoogleMap(
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition!,
                      zoom: 10.0,
                    ),
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      Future.delayed(Duration(milliseconds: 4000), () {
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _initialPosition!,
                              zoom: 14.0,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.appRed,
                        ),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.back,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.appRed,
                        ),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.share,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 8,
                      left: 8,
                    ),
                    width: size.width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 88, 88, 88).withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 228, 227, 227)
                              .withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: EventCardRow(
                      event: EventModel.eventList[0],
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
