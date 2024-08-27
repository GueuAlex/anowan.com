import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/show_share_location_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/localization_model.dart';
import 'add_agenda_bottom_sheet.dart';
import 'icon_row.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    this.localizations = const [],
    required this.title,
    required this.description,
  });
  final List<LocalizationModel> localizations;
  final String title;
  final String description;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int _selectedIndex = 0;
  late LocalizationModel _selectedLocalization;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _selectedLocalization = widget.localizations[_selectedIndex];
    });
    //widget.localizations.addAll(LocalizationModel.localList);
    bool isMultipleLocalization = widget.localizations.length > 1;

    return Column(
      children: [
        isMultipleLocalization
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                //height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      widget.localizations.length,
                      (index) => InkWell(
                        child: GestureDetector(
                          onTap: () => _selectLocalization(index),
                          child: Container(
                            //width: 100,
                            //height: 150,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Palette.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 2,
                                color: _selectedIndex == index
                                    ? Palette.primaryColor
                                    : Palette.primaryColor.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppText.medium(
                                  DateFormat('EEEE', 'fr_FR').format(
                                      widget.localizations[index].dateEvent),
                                  fontWeight: FontWeight.w300,
                                ),
                                Container(
                                  //width: 150,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  //height: 60,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 37, 47, 47),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      AppText.medium(
                                        DateFormat('dd', 'fr_FR').format(widget
                                            .localizations[index].dateEvent),
                                        color: Palette.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      //Gap(5),
                                      AppText.medium(
                                        DateFormat('MMM', 'fr_FR').format(
                                          widget.localizations[index].dateEvent,
                                        ),
                                        color: Palette.appRed,
                                      ),
                                    ],
                                  ),
                                ),
                                AppText.medium(
                                  widget.localizations[index].starttimeEvent,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        ////////
        IconRow(
          onTap: _addToCalendar,
          icon: FluentIcons.calendar_24_regular,
          title: DateFormat('EEEE dd. MMM yyyy', 'fr_FR').format(
            _selectedLocalization.dateEvent,
          ),
          subtitle: '🕐 ${_selectedLocalization.starttimeEvent}',
        ),
        IconRow(
          onTap: _showShareLocation,
          icon: FluentIcons.location_24_regular,
          title: 'Nom du lieu',
          subtitle: 'Adresse complète du lieu de l\'événement',
        ),
        IconRow(
          onTap: _launchUrl,
          icon: FluentIcons.money_24_regular,
          title: 'Politique de remboursement',
          subtitle: 'Remboursements jusqu\'à un jour avant l\'événement.',
        ),
        ///////
      ],
    );
  }

  void _selectLocalization(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedLocalization = widget.localizations[index];
    });
  }

  void _showShareLocation() {
    Functions.showSimpleBottomSheet(
      ctxt: context,
      widget: ShowShareLocationBottomSheet(
        localization: _selectedLocalization,
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
      'https://anowan.com/terms-and-policies/terms-of-service',
    );
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _addToCalendar() {
    // final size = MediaQuery.of(context).size;
    Functions.showSimpleBottomSheet(
      ctxt: context,
      widget: AddToAgendaContainer(
        localization: _selectedLocalization,
        title: widget.title,
        description: widget.description,
      ),
    );
  }
}
