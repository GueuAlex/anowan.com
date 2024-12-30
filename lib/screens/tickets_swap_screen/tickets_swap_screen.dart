import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../constants/constants.dart';
import '../../model/ticket_model.dart';
import '../../widgets/app_bar.dart';
import 'widgets/ticket_view_custom.dart';

class TicketsSwapScreen extends StatefulWidget {
  static String routeName = 'ticketsSwapScreen';
  const TicketsSwapScreen({super.key});

  @override
  State<TicketsSwapScreen> createState() => _TicketsSwapScreenState();
}

class _TicketsSwapScreenState extends State<TicketsSwapScreen> {
  @override
  Widget build(BuildContext context) {
    final tickets =
        ModalRoute.of(context)!.settings.arguments as List<TicketModel>;

    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/anowan-placeholder.png',
              image: tickets[0].event.image ?? networtImgPlaceholder,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/anowan-placeholder.png',
                  fit: BoxFit.cover,
                );
              },
              width: double.infinity,
            ),
          ),
          // Effet de verre
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Flou
              child: Container(
                color: Colors.black.withOpacity(0.2), // Teinte transparente
              ),
            ),
          ),
          // Contenu principal

          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Swiper(
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TicketViewCustom(
                        index: index + 1,
                        ticket: tickets[index],
                      ),
                    ),
                  );
                },
                itemCount: tickets.length,
                pagination: const SwiperPagination(),
                // control: const SwiperControl(),
              ), // Votre widget
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: AppBarCusttom(
                leadingText: '',
                title: '${tickets[0].event.name}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
