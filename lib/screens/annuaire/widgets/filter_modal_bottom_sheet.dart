import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import '../../../widgets/infos_column.dart';

class FilterModalBottomeSheet extends StatefulWidget {
  const FilterModalBottomeSheet({super.key});

  @override
  State<FilterModalBottomeSheet> createState() =>
      _FilterModalBottomeSheetState();
}

class _FilterModalBottomeSheetState extends State<FilterModalBottomeSheet> {
  List<String> _selectedTags = [];
  List<String> _selectedCities = [];
  List<String> _selectedCommunes = [];
  double _currentSliderValue = 50000.0;
  // String? _sliderStatus;

  List<String> cities = [
    "Abidjan",
    "Bouaké",
    "Daloa",
    "San-Pédro",
    "Yamoussoukro",
    "Korhogo",
    "Man",
    "Divo",
    "Gagnoa",
    "Anyama",
    "Abengourou",
    "Agboville",
    "Séguéla",
    "Bondoukou",
    "Odienné",
    "Ferkessédougou",
    "Sinfra",
    "Katiola",
    "Soubré",
    "Toumodi"
  ];

  List<String> communes = [
    "Cocody",
    "Yopougon",
    "Abobo",
    "Marcory",
    "Treichville",
    "Adjame",
    "Plateau",
    "Koumassi",
    "Port-Bouet",
    "Attécoubé",
    "Songon"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cupertinoHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(
                    '#Tags',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(10),
                  Wrap(
                    children: PrestatorMdel.getAllUniqueTags(
                            prestatorsList: PrestatorMdel.prestators)
                        .map((tag) => _buildTag(tag))
                        .toList(),
                  ),
                  Gap(25),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                      ),
                      AppText.medium(
                        'Lieux',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Gap(10),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 188, 188, 188),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          'Communes',
                          fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),
                        Wrap(
                          children: communes
                              .map((tag) => _buildTag(tag, type: 'commune'))
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  // villes
                  Gap(10),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 188, 188, 188),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          'Villes',
                          fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),
                        Wrap(
                          children: cities
                              .map(
                                (tag) => _buildTag(tag, type: 'city'),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  // price range
                  AppText.medium(
                    '\$Budget',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(10),
                  // Display the current slider value.
                  Row(
                    children: [
                      Expanded(
                        child: InfosColumn(
                          label: 'Entre',
                          widget: Expanded(
                            child: AppText.medium(
                              '50000 F CFA',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InfosColumn(
                          label: 'Et',
                          widget: Expanded(
                            child: AppText.medium(
                              '$_currentSliderValue F CFA',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap(10),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlider(
                      key: const Key('slider'),
                      value: _currentSliderValue,
                      min: 50000.0,
                      // This allows the slider to jump between divisions.
                      // If null, the slide movement is continuous.
                      divisions: 100,
                      // The maximum slider value
                      max: 1000000,
                      activeColor: Palette.appRed,
                      thumbColor: Palette.appRed,
                      // This is called when sliding is started.
                      /*  onChangeStart: (double value) {
                        setState(() {
                          _sliderStatus = 'Sliding';
                        });
                      }, */
                      // This is called when sliding has ended.
                      /* onChangeEnd: (double value) {
                        setState(() {
                          _sliderStatus = 'Finished sliding';
                        });
                      }, */
                      // This is called when slider value is changed.
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 248, 248),
              border: Border(
                top: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            child: SafeArea(
              child: Container(
                height: 40,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Palette.appRed),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: AppText.medium(
                    'Appliquer',
                    fontSize: 16.8,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, {String type = 'tag'}) {
    bool isSelected = _selectedTags.contains(label);
    bool isSelectedCity = _selectedCities.contains(label);
    bool isSelectedCommune = _selectedCommunes.contains(label);
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: !isSelected && !isSelectedCity && !isSelectedCommune
            ? Palette.primaryColor.withOpacity(0.1)
            : Palette.appRed,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => _onTagTap(label, type),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.medium(
              label,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isSelected || isSelectedCity || isSelectedCommune
                  ? Palette.whiteColor
                  : Color.fromARGB(255, 20, 26, 40),
            ),
            Gap(5),
            isSelected || isSelectedCity || isSelectedCommune
                ? Icon(
                    CupertinoIcons.xmark,
                    size: 14,
                    color: Palette.whiteColor,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _onTagTap(String label, String type) {
    if (type == 'tag') {
      setState(() {
        if (_selectedTags.contains(label)) {
          _selectedTags.remove(label);
        } else {
          _selectedTags.add(label);
        }
      });
    } else if (type == 'city') {
      setState(() {
        if (_selectedCities.contains(label)) {
          _selectedCities.remove(label);
        } else {
          _selectedCities.add(label);
        }
      });
    } else if (type == 'commune') {
      setState(() {
        if (_selectedCommunes.contains(label)) {
          _selectedCommunes.remove(label);
        } else {
          _selectedCommunes.add(label);
        }
      });
    }
  }

  Container _cupertinoHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Palette.separatorColor,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            child: AppText.small(
              'Annuler',
              fontSize: 14.3,
              color: Palette.appRed,
              letterSpacing: 0.2,
            ),
          ),
          AppText.medium(
            'Filtres',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            child: AppText.small(
              'Réinitialiser',
              fontSize: 14.3,
              color: Palette.appRed,
              letterSpacing: 0.2,
            ),
          )
        ],
      ),
    );
  }
}
