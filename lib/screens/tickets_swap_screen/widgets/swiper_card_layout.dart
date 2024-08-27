import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../model/ticket_model.dart';
import 'build_swiper.dart';
import 'height_spacer.dart';
import 'top_buttons.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    Key? key,
    required this.tickest,
  }) : super(key: key);
  final List<TicketModel> tickest;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            tickest[0].event.image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
              // bottomLeft: Radius.circular(35),
              // bottomRight: Radius.circular(35),
              ),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              // Color.fromARGB(255, 217, 217, 217),
              Color.fromARGB(156, 0, 0, 0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              0.05,
              /* 0.05, */ 0.3
            ], // Adjust this to control the gradient
          ),
        ),
        child: Column(
          children: [
            HeightSpacer(myHeight: kSpacing),
            SafeArea(child: const HeaderWidgets()),
            HeightSpacer(myHeight: kSpacing / 2),
            const SwiperBuilder(),
          ],
        ),
      ),
    );
  }
}
