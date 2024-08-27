import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';
//import 'package:ticketwave/model/ticket_model.dart';

import '../../model/ticket_model.dart';
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

class EnventInfos extends StatefulWidget {
  const EnventInfos({
    super.key,
  });

  @override
  State<EnventInfos> createState() => _EnventInfosState();
}

class _EnventInfosState extends State<EnventInfos> {
  bool _showMore = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              _ticketsLength(),
              Gap(5),
              Expanded(
                child: Expanded(
                  child: _placeAndDate(),
                ),
              ),
            ],
          ),
        ),
        Gap(15),
        _eventNameContainer(),
        Gap(10),
        Container(
          width: double.infinity,
          height: 0.8,
          color: Palette.separatorColor,
        ),
        _showMoreLessWidget()
      ],
    );
  }

  Widget _showMoreLessWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'Important',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          SizedBox(height: 10),
          AppText.small(
            '1- Il est crucial de conserver rigoureusement votre ticket.',
            fontSize: 13,
          ),
          SizedBox(height: 5),
          AppText.small(
            '2- Votre ticket doit être présenté une fois arrivé à l\'événement.',
            fontSize: 13,
          ),
          SizedBox(height: 5),
          AppText.small(
            '3- Chaque type de ticket est unique et ne peut être scanné qu\'une seule fois sauf cas spéciaux.',
            fontSize: 13,
          ),
          SizedBox(height: 5),
          if (_showMore)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.small(
                  '4- Assurez-vous que votre ticket est stocké en toute sécurité et à l\'abri des regards indiscrets.',
                  fontSize: 13,
                ),
                SizedBox(height: 5),
                AppText.small(
                  '5- En cas de perte ou de vol, votre ticket ne pourra pas être remplacé. Il est donc fortement recommandé de ne pas partager votre ticket avec d\'autres personnes.',
                  fontSize: 13,
                ),
                SizedBox(height: 5),
                AppText.small(
                  '6- Toute tentative de reproduction ou d\'altération du ticket est strictement interdite et entraînera des sanctions.',
                  fontSize: 13,
                ),
                SizedBox(height: 5),
                AppText.small(
                  '7- Pour des raisons de sécurité, les organisateurs se réservent le droit de refuser l\'entrée à toute personne présentant un ticket suspect.',
                  fontSize: 13,
                ),
              ],
            ),
          //SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              setState(() {
                _showMore = !_showMore;
              });
            },
            child: Text(
              _showMore ? 'Reduire' : 'Voir la suite',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeAndDate() => Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: Icon(
              FluentIcons.location_24_regular,
              size: 55,
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppText.medium(
                    DateFormat('📆 EEEE d MMMM yyyy à HH:mm', 'fr').format(
                      DateTime.now(),
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(),
                Expanded(
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          '📍Jardin Event - Robert\'s Hôtel',
                          maxLine: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        AppText.small('Cocody, Abidjan - Côte d\'ivoire'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Container _ticketsLength() {
    return Container(
      width: 110,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 30, 122, 147).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 0,
            child: Icon(
              FluentIcons.ticket_diagonal_24_regular,
              size: 55,
              color: Color.fromARGB(255, 30, 122, 147).withOpacity(0.4),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.large(
                '3',
                color: Color.fromARGB(255, 30, 122, 147),
              ),
              //Gap(5),
              Divider(
                height: 25,
              ),
              Expanded(
                child: AppText.large(
                  'Tickets',
                  textAlign: TextAlign.center,
                  color: Color.fromARGB(255, 30, 122, 147),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _eventNameContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        //color: Palette.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Palette.separatorColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/expert.jpeg'),
              ),
              border: Border.all(
                width: 3,
                color: Palette.primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(
                  'Noblesse Sweetness & Food',
                  //textAlign: TextAlign.right,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                AppText.small(
                  '12K Participants ',
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 16,
          ),
        ],
      ),
    );
  }
}
