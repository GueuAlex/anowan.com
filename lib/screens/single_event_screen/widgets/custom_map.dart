import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

import '../../../config/palette.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    super.key,
    required this.location,
  });

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Hauteur de la carte
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: location, // Centre de la carte
            initialZoom: 19.0,
            // Zoom de la carte
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.digifaz.anowan',
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                    Uri.parse(
                      'https://openstreetmap.org/copyright',
                    ),
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 80,
                  height: 80,
                  child: Icon(
                    FluentIcons.location_24_filled,
                    color: Palette.appRed,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
