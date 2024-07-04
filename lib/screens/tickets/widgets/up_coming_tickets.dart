import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/ticket_model.dart';
import 'ticket_preview.dart';
import 'tickets_missing.dart';

class UpCommingTickets extends StatefulWidget {
  const UpCommingTickets({
    super.key,
  });

  @override
  State<UpCommingTickets> createState() => _UpCommingTicketsState();
}

class _UpCommingTicketsState extends State<UpCommingTickets> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool ticketListEmpty = TicketModel.tickList.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Vos billets d\'évènements',
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
                  'BILLETS À VENIR',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  1,
                  Icons.star,
                  'BILLETS PASSÉS',
                ),
              ),
            ],
          ),
        ),
        Gap(20),
        IndexedStack(
          index: _selectedIndex,
          alignment: Alignment.center,
          children: [
            ticketListEmpty
                ? ticketsMissing(
                    size: size,
                  )
                : _ticketsRow(size: size),
            //_ticketsMissing(size: size),
            ticketsMissing(
              size: size,
              text:
                  'Vos billets d\'évènements s\'affichent ici une fois qu\'ils sont  scanné ou que l\'évènement est terminé',
            ),
          ],
        ),
      ],
    );
  }

  /*  Widget _ticketsRow() => Row(
        children: TicketModel.tickList
            .map(
              (ticket) => Expanded(
                child: TicketPreview(
                  date: '12 Jan 2024',
                  time: '18:00',
                  eventName: 'Concert de Youssou N\'Dour',
                  location: 'Stade Félix Houphouët-Boigny',
                  imageUrl: 'https://picsum.photos/id/10/200/300',
                ),
              ),
            )
            .toList(),
      ); */

  Widget _ticketsRow({required Size size}) {
    return BannerCarousel(
      height: 150,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedIndicators:
          IndicatorModel(width: 5, height: 5, spaceBetween: 3),
      customizedBanners: List.generate(
        TicketModel.tickList.length,
        (index) {
          final ticket = TicketModel.tickList[index];
          return TicketPreview(
            date: DateFormat('dd MMM yyyy').format(
              ticket.event.localizations[0].dateEvent,
            ),
            time: ticket.event.localizations[0].starttimeEvent,
            eventName: ticket.event.name,
            location: ticket.event.localizations[0].place,
            imageUrl: ticket.event.image,
          );
        },
      ),
    );
  }

  //
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
