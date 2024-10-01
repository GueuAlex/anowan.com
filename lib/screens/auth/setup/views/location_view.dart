import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/constants.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
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
    //const String apki = mapsApiKey;
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=$mapsApiKey&sessiontoken=$uuid';
      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large('Où etes-vous ?'),
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
                color: Palette.appRed,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
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
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      _placeController.clear();
                    }),
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          /*  TextField(
            controller: _placeController,
            decoration: const InputDecoration(hintText: 'Searche place'),
            onChanged: (value) {
              setState(() {});
            },
          ), */
          Gap(5),
          Visibility(
            visible: _placeController.text.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOfLocations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
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
          )
        ],
      ),
    );
  }
}
