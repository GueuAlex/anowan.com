import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../config/app_text.dart';
import '../config/palette.dart';
import '../model/event_model.dart';
import '../screens/single_event_screen/single_event_screen.dart';

Widget eventCardColumn(
    {required EventModel event,
    required Size size,
    required BuildContext context}) {
  final String date = DateFormat("EEE dd MMM", 'fr')
      .format(event.localizations[0].dateEvent)
      .toUpperCase();

  return InkWell(
    onTap: () => Navigator.pushNamed(
      context,
      SingleEventScreen.routeName,
      /*  arguments:  */
      arguments: event,
    ),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(
            width: 0.8,
            color: const Color.fromARGB(255, 216, 216, 216),
          )
          /*  boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ], */
          ),
      margin: EdgeInsets.only(top: 20, bottom: 45, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: size.width * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6.8,
                /*  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(event.image),
                    /* image: AssetImage("assets/images/two.png"), */
                    fit: BoxFit.cover,
                  ),
                ), */
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/anowan-placeholder.png',
                  image: event.image,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/anowan-placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                  width: double.infinity,
                  height: size.width * 0.25,
                ),
              ),
              /*  Expanded(
                  child: */
              Container(
                width: double.infinity,
                height: size.height * 0.18,
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          '${date}  \u2022 ${event.localizations[0].starttimeEvent}',
                          fontSize: (size.width * 0.033),
                          color: Palette.appRed,
                          //fontWeight: FontWeight.w600,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: AppText.medium(
                            '${event.name} ',
                            fontSize: (size.width * 0.048),
                            fontWeight: FontWeight.w700,
                            maxLine: 2,
                            color: Color.fromARGB(255, 39, 40, 41),
                          ),
                        ),
                        Gap(5),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: AppText.small(
                            event.organizer.name,
                            fontSize: (size.width * 0.033),
                            fontWeight: FontWeight.w300,
                            maxLine: 1,
                            color: Color.fromARGB(255, 37, 40, 42),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color.fromARGB(255, 141, 141, 141),
                                    size: 23,
                                  ),
                                  Gap(2),
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
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => print('share'),
                                  child: Icon(
                                    CupertinoIcons.share,
                                    color: const Color.fromARGB(
                                      255,
                                      105,
                                      105,
                                      105,
                                    ),
                                    size: 20,
                                  ),
                                ),
                                Gap(14),
                                GestureDetector(
                                  onTap: () => print('bookmark'),
                                  child: Icon(
                                    CupertinoIcons.bookmark,
                                    color: const Color.fromARGB(
                                      255,
                                      105,
                                      105,
                                      105,
                                    ),
                                    size: 20,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}
