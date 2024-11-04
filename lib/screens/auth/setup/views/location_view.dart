import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../constants/constants.dart';
import '../../../../providers/providers.dart';

class LocationView extends ConsumerStatefulWidget {
  const LocationView({super.key});

  @override
  ConsumerState<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends ConsumerState<LocationView> {
  final TextEditingController _placeController = TextEditingController();
  var uuid = const Uuid().v4();
  List<dynamic> listOfLocations = [];

  @override
  void initState() {
    _placeController.addListener(() {
      _onChange();
    });
    super.initState();
  }

  _onChange() {
    placeSuggestion(_placeController.text);
  }

  placeSuggestion(String place) async {
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=$mapsApiKey&sessiontoken=$uuid';
      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          listOfLocations = data['predictions'];
        });
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Utilisation de selectedPlaceProvider
    // final selectedPlace = ref.watch(selectedPlaceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large('Où êtes-vous ?'),
          Gap(3),
          AppText.medium(
            'Indiquez votre localisation pour trouver les événements et les prestataires de services évènementiels proches de vous.',
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
          Gap(15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.03),
              border: Border.all(
                color: Palette.separatorColor,
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.search,
                  size: 20,
                ),
                Gap(8),
                Expanded(
                  child: Functions.getTextField(
                      controller: _placeController,
                      textFieldLabel: 'Trouver un lieu'),
                ),
                Gap(8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Palette.appRed.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      _placeController.clear();
                      listOfLocations.clear(); // Clear suggestions
                    }),
                    child: Icon(
                      Icons.my_location,
                      size: 14,
                      color: Palette.appRed,
                    ),
                  ),
                )
              ],
            ),
          ),
          Gap(5),
          Visibility(
            visible: _placeController.text.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: listOfLocations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      //EasyLoading.show();
                      String _place = listOfLocations[index]['description'];

                      // Mettre à jour le provider selectedPlaceProvider
                      ref.read(selectedPlaceProvider.notifier).state = _place;

                      setState(() {
                        _placeController.text = _place;
                        listOfLocations.clear(); // Clear suggestions
                      });
                      // EasyLoading.dismiss();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(FluentIcons.location_24_regular, size: 20),
                          Gap(5),
                          Expanded(
                            child: Text(
                              listOfLocations[index]['description'],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
