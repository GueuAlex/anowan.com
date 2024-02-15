import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import 'icon_row.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 0;
    final List<DateTime> dates = [
      DateTime.now(),
      DateTime.now().add(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 2)),
      DateTime.now().add(const Duration(days: 3)),
      DateTime.now().add(const Duration(days: 4)),
    ];
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          //height: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                dates.length,
                (index) => InkWell(
                  child: Container(
                    //width: 100,
                    //height: 150,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 2,
                        color: selectedIndex == index
                            ? Palette.primaryColor
                            : Palette.primaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppText.medium(
                          DateFormat('EEEE', 'fr_FR').format(dates[index]),
                          fontWeight: FontWeight.w300,
                        ),
                        Container(
                          //width: 150,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          //height: 60,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 37, 47, 47),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              AppText.medium(
                                DateFormat('dd', 'fr_FR').format(dates[index]),
                                color: Palette.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(5),
                              AppText.medium(
                                DateFormat('MMM', 'fr_FR').format(
                                  dates[index],
                                ),
                                color: Palette.appRed,
                              ),
                            ],
                          ),
                        ),
                        AppText.medium(
                          DateFormat('HH:12', 'fr_FR').format(
                            dates[index],
                          ),
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
        ////////
        IconRow(
          icon: FluentIcons.calendar_24_regular,
          title:
              DateFormat('EEE. dd. MMM yyyy', 'fr_FR').format(DateTime.now()),
          subtitle: '11:00 - 0:00',
        ),
        IconRow(
          icon: FluentIcons.location_24_regular,
          title: 'Seen Hotel',
          subtitle: 'Seen Hotel Abidjan Plateau, District Autonome d\'Abidjan',
        ),
        IconRow(
          icon: FluentIcons.money_24_regular,
          title: 'Politique de remboursement',
          subtitle: 'Remboursements jusqu\'à un jour avant l\'événement.',
        ),
        ///////
      ],
    );
  }
}
