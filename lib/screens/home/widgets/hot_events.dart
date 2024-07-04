import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/model/event_model.dart';
import 'package:ticketwave/widgets/event_card_row.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class HotEvents extends StatelessWidget {
  const HotEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'Les plus hots 🔥',
            fontSize: (size.width * 0.042),
            fontWeight: FontWeight.w500,
          ),

          Gap(15),
          _mostViewedPrestators(size: size),
          //AppText.large('data')
        ],
      ),
    );
  }

  Widget _mostViewedPrestators({required Size size}) {
    return BannerCarousel(
      height: 125,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedIndicators:
          IndicatorModel(width: 0, height: 0, spaceBetween: 0),
      customizedBanners: List.generate(
        EventModel.eventList.length,
        (index) => EventCardRow(
          event: EventModel.eventList[index],
        ),
      ),
    );
  }
}
