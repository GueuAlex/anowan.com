import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../config/app_text.dart';
import '../config/palette.dart';
import '../constants/constants.dart';
import '../model/event_model.dart';
import '../screens/single_event_screen/single_event_screen.dart';
import 'bookmark_event.dart';

class EventCardRow extends StatelessWidget {
  const EventCardRow({
    super.key,
    required this.event,
    this.color = const Color.fromARGB(255, 250, 250, 250),
  });
  final EventModel event;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () => Navigator.pushNamed(
        context,
        SingleEventScreen.routeName,
        /*  arguments:  */
        arguments: event,
      ),
      child: Card(
        color: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 120, maxHeight: 125),
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: double.infinity,
                      height: size.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/anowan-placeholder.png',
                          image: event.image ?? networtImgPlaceholder,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/anowan-placeholder.png',
                              fit: BoxFit.cover,
                            );
                          },
                          width: double.infinity,
                          height: size.height,
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
                        AppText.medium(
                          '${DateFormat('EEE MMM dd', 'fr_FR').format(
                            event.localizations[0].dateEvent,
                          )} \u2022 ${event.localizations[0].starttimeEvent} GMT+00:00',
                          fontSize: (size.width * 0.033),
                          color: Palette.appRed,
                          maxLine: 1,
                          //fontWeight: FontWeight.w500,
                        ),
                        Gap(2),
                        AppText.medium(
                          event.name,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: (size.width * 0.048),
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                          color: Color.fromARGB(255, 39, 40, 41),
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Palette.primaryColor,
                            ),
                            Gap(8),
                            Expanded(
                              child: AppText.small(
                                event.localizations[0].place ?? '',
                                textOverflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 107, 120, 122),
                              ),
                            )
                          ],
                        ),
                        Gap(8),
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
                                size: 16,
                              ),
                            ),
                            Gap(14),
                            BookmarkEvent(
                              event: event,
                              size: 16,
                            ),
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
                child: event.free
                    ? Container(
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
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
