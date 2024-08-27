import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../model/event_model.dart';
import 'favorites_container.dart';

Widget favorites({required Size size}) {
  return BannerCarousel(
    height: 190,
    margin: const EdgeInsets.all(0),
    activeColor: Palette.appRed,
    customizedBanners: List.generate(
      EventModel.eventList.sublist(0, 3).length,
      (index) => favoriteEventsContainer(
          size: size, event: EventModel.eventList[index]),
    ),
  );
}
