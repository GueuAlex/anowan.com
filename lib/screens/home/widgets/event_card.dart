import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/screens/single_event_screen/single_event_screen.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        SingleEventScreen.routeName,
        /*  arguments:  */
      ),
      child: Card(
        color: Palette.whiteColor,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 120, maxHeight: 100),
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 15, top: 2, bottom: 2),
                      width: double.infinity,
                      height: size.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        child: Image.asset(
                          'assets/images/concert-demo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Gap(2),
                  Expanded(
                    child: Column(
                      // mainAxisSize: ,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.small(
                          '${DateFormat('EEE MMM dd', 'fr_FR').format(
                            DateTime.now().add(
                              Duration(days: index),
                            ),
                          )} \u2022 1$index:00 GMT+00:00',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 190, 67, 10),
                        ),
                        Gap(2),
                        AppText.medium(
                          'Abidjan Rhum Festival 2023',
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Icon(
                              FluentIcons.location_24_filled,
                              size: 13,
                              color: Palette.primaryColor,
                            ),
                            Gap(8),
                            Expanded(
                              child: AppText.small(
                                'Seen Hotel Abidjan Plateau',
                                textOverflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 107, 120, 122),
                              ),
                            )
                          ],
                        ),
                        Gap(3),
                        Row(
                          children: [
                            Icon(FluentIcons.person_24_regular, size: 18),
                            Expanded(
                              child: AppText.small(
                                ' 445 Participants',
                                fontWeight: FontWeight.w500,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(FluentIcons.share_24_regular),
                            Gap(8),
                            Icon(FluentIcons.heart_24_regular),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              ///////////////////
              ///
              Positioned(
                left: 45,
                top: 10,
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Palette.primaryColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: AppText.small(
                      'Gratuit',
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
