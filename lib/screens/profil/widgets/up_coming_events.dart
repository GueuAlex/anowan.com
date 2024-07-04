import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/event_model.dart';

import '../../../config/app_text.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({
    super.key,
  });

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Évènements à venir',
          fontSize: (size.width * 0.042),
          fontWeight: FontWeight.w500,
        ),
        Gap(20),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: const Color.fromARGB(255, 199, 199, 199),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildTabButton(
                  0,
                  Icons.home,
                  'PARTICIPE',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  1,
                  Icons.star,
                  'FAVORITES',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  2,
                  Icons.settings,
                  'SUGGESTIONS',
                ),
              ),
            ],
          ),
        ),
        Gap(20),
        IndexedStack(
          index: _selectedIndex,
          children: [
            _participed(size: size),
            _favorites(size: size),
            _suggestions(size: size)
          ],
        ),
      ],
    );
  }

  Widget _favorites({required Size size}) {
    return BannerCarousel(
      height: 190,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedBanners: List.generate(
        EventModel.eventList.length,
        (index) => _favoriteEventsContainer(
            size: size, event: EventModel.eventList[index]),
      ),
    );
  }

  Widget _participed({required Size size}) {
    //List<BannerModel> listBanners = [];
    return BannerCarousel(
      height: 190,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedBanners: List.generate(
        EventModel.eventList.length,
        (index) => _participedEventsContainer(
            size: size, event: EventModel.eventList[index]),
      ),
    );
  }

  Container _favoriteEventsContainer({
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

  Container _participedEventsContainer({
    required Size size,
    required EventModel event,
  }) {
    final String date = DateFormat("EEE dd MMM", 'fr')
        .format(event.localizations[0].dateEvent)
        .toUpperCase();
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, right: 5, left: 5),
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                AppText.medium(
                  '${date}  \u2022 ${event.localizations[0].starttimeEvent}',
                  fontSize: (size.width * 0.033),
                  color: Palette.appRed,
                  //fontWeight: FontWeight.w600,
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
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.appRed,
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.check_mark,
                          color: Colors.white,
                          size: 11,
                        ),
                      ),
                    ),
                    Gap(5),
                    Flexible(
                      child: AppText.small(
                        '499 Participants \u2022 ${event.localizations[0].place}',
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
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.share,
                  size: 16,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _suggestions({required Size size}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      padding: const EdgeInsets.all(10),
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AppText.medium(
              'Obtenir des suggestions d\'événements',
              fontSize: size.width * 0.040,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3, bottom: 10),
            child: AppText.small(
              'Vous avez ${19} suggestions d\'événements à venir',
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            decoration: BoxDecoration(
              color: Palette.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              onTap: () {},
              child: AppText.medium(
                'Afficher les suggestions d\'évènements',
                fontSize: size.width * 0.040,
                textAlign: TextAlign.center,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, IconData icon, String text) {
    final bool isSelected = _selectedIndex == index;
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2.5,
            color: isSelected ? Palette.appRed : Colors.transparent,
          ),
        ),
      ),
      child: InkWell(
        onTap: () => _onTabSelected(index),
        child: Center(
          child: AppText.medium(
            text,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color:
                isSelected ? Palette.appRed : Color.fromARGB(167, 67, 67, 67),
          ),
        ),
      ),
    );
  }
}
