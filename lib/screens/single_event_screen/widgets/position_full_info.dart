import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart'; // Import du package
import 'package:ticketwave/constants/constants.dart';

import '../../../config/app_text.dart';

class PositionFullInfo extends StatefulWidget {
  const PositionFullInfo({
    super.key,
    required this.icons,
    required this.location,
  });

  final List<String> icons;
  final LatLng location;

  @override
  _PositionFullInfoState createState() => _PositionFullInfoState();
}

class _PositionFullInfoState extends State<PositionFullInfo> {
  late GoogleMapsGeocoding geocoding;
  String? place;
  String? address;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    geocoding = GoogleMapsGeocoding(apiKey: mapsApiKey);
    _fetchLocationInfo();
  }

  Future<void> _fetchLocationInfo() async {
    try {
      // Appel à l'API de geocoding
      final response = await geocoding.searchByLocation(
        Location(lat: widget.location.latitude, lng: widget.location.longitude),
      );

      if (response.results.isNotEmpty) {
        final result = response.results.first;
        String? formattedAddress = result.formattedAddress;
        print(formattedAddress);

        if (formattedAddress != null) {
          // Supprimer le préfixe "+00225" s'il existe
          if (formattedAddress.startsWith('+00225')) {
            formattedAddress = formattedAddress
                .replaceFirst('+00225 ', '')
                .replaceAll(',', '');
          }

          // Séparer l'adresse principale du reste des détails en utilisant la première virgule
          final addressParts = formattedAddress.split(' ');
          print(addressParts.length);

          // Récupérer la première partie (quartier/ville)
          String mainAddress = "";
          if (addressParts.isEmpty) {
            mainAddress = 'Adresse inconnue';
          } else if (addressParts.length >= 2) {
            mainAddress = addressParts.sublist(0, 2).join(' ').trim();
          } else {
            mainAddress = addressParts.first;
          }

          // Récupérer le reste des détails de l'adresse
          // Récupérer le reste des détails de l'adresse en fonction des conditions plus haut
          String detailedAddress = "";
          if (addressParts.isEmpty || addressParts.length == 1) {
            // Si l'adresse est vide ou contient un seul élément
            detailedAddress = 'Détails indisponibles';
          } else if (addressParts.length >= 3) {
            // Si l'adresse contient au moins 4 parties, les détails sont tout ce qui vient après les trois premières parties
            detailedAddress = addressParts.sublist(2).join(' ').trim();
          } else {
            // Si l'adresse contient 2 ou 3 parties, les détails sont tout ce qui vient après la première partie
            detailedAddress = addressParts.sublist(1).join(' ').trim();
          }

          setState(() {
            place = mainAddress.trim();
            address = detailedAddress;
            isLoading = false;
          });
        } else {
          setState(() {
            place = null;
            address = null;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          place = null;
          address = null;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Erreur lors de la récupération des données : $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    //affiche l'erreur si une erreur est rencontrée
    /*   if (error != null) {
      return Center(child: Text(error!));
    } */

    if (place == null || address == null) {
      return Center(child: Text('Aucune donnée de lieu disponible'));
    }

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
              place!,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              maxLine: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            Gap(8),
            AppText.medium(
              address!,
              fontSize: 15,
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.icons.length,
                (index) => Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800.withOpacity(
                      0.15,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SvgPicture.asset(widget.icons[index]),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
