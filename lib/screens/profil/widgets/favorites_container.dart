import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/event_model.dart';

Container favoriteEventsContainer({
  required Size size,
  required EventModel event,
}) {
  final String date = DateFormat("EEE dd MMM", 'fr')
      .format(event.localizations[0].dateEvent)
      .toUpperCase();
  return Container(
    margin: const EdgeInsets.only(bottom: 10, top: 10, right: 5, left: 5),
    padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 8),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.medium(
                    '${date}  \u2022 ${event.localizations[0].starttimeEvent}',
                    fontSize: (size.width * 0.033),
                    color: Palette.appRed,
                    //fontWeight: FontWeight.w600,
                  ),
                  Icon(
                    CupertinoIcons.bookmark_fill,
                    color: Palette.appRed,
                    size: 18,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: AppText.medium(
                  '${event.name}',
                  fontSize: (size.width * 0.048),
                  fontWeight: FontWeight.w700,
                  maxLine: 2,
                  color: Color.fromARGB(255, 39, 40, 41),
                ),
              ),
              Gap(5),
              Flexible(
                child: AppText.small(
                  'Nom de l\'organisateur ici',
                  fontSize: (size.width * 0.033),
                  fontWeight: FontWeight.w300,
                  maxLine: 1,
                  color: Color.fromARGB(255, 37, 40, 42),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 141, 141, 141),
                    size: 16,
                  ),
                  Gap(5),
                  Flexible(
                    child: AppText.small(
                      '${event.localizations[0].place}',
                      fontSize: size.width * 0.029,
                      fontWeight: FontWeight.w300,
                      maxLine: 1,
                      color: Color.fromARGB(255, 37, 40, 42),
                      textOverflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Palette.primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: AppText.medium(
                'Participer',
                color: Palette.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    ),
  );
}