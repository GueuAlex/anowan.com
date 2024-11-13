import 'package:flutter/material.dart';

//import 'package:ticketwave/model/ticket_model.dart';

import '../../model/ticket_model.dart';
import 'widgets/event_infos.dart';
import 'widgets/swiper_card_layout.dart';

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
          CardLayout(
            tickest: tickets,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: EnventInfos(),
            ),
          ),
        ],
      ),
    );
  }
}
