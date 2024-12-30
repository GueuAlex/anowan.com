import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket/flutter_ticket.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/ticket_model.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../constants/constants.dart';
import '../../../widgets/qrcode_dialog.dart';

class TicketViewCustom extends StatelessWidget {
  const TicketViewCustom({
    super.key,
    required this.index,
    required this.ticket,
  });
  final int index;
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Ticket(
          innerRadius: BorderRadius.circular(10),
          outerRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4.0),
              blurRadius: 2.0,
              spreadRadius: 2.0,
              color: Color.fromRGBO(196, 196, 196, 0.256),
            )
          ],
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.26,
              maxHeight: size.height * 0.26,
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.8,
            ),
            /* child: Image.asset(
              'assets/images/concert-demo.jpg',
              fit: BoxFit.cover,
            ), */
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/anowan-placeholder.png',
              image: ticket.event.image ?? networtImgPlaceholder,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/anowan-placeholder.png',
                  fit: BoxFit.cover,
                );
              },
              width: double.infinity,
              //height: size.width * 0.25,
            ),
          ),
        ),
        Ticket(
          innerRadius: BorderRadius.circular(10.0
              /* topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0), */
              ),
          outerRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 2.0,
              spreadRadius: 2.0,
              color: Color.fromRGBO(196, 196, 196, 0.091),
            )
          ],
          child: Container(
            color: Colors.white,
            // width: 300,
            constraints: BoxConstraints(
              // minHeight: size.height * 0.5,
              //maxHeight: size.height * 0.5,
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.8,
            ),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            FluentIcons.ticket_diagonal_24_regular,
                            color: Palette.appRed,
                          ),
                          Text(
                            'Ticket n° $index',
                            style: GoogleFonts.sacramento(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            FluentIcons.ticket_diagonal_24_regular,
                            color: Palette.appRed,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Palette.appRed,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Center(
                        child: Text(
                          '${ticket.pass.name.toUpperCase()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InfosCard(
                            text2:
                                '${DateFormat('dd/MM').format(ticket.event.localizations[0].dateEvent)}',
                          ),
                        ),
                        Expanded(
                          child: InfosCard(
                              text1: 'Heure',
                              text2:
                                  '${ticket.event.localizations[0].starttimeEvent}'),
                        ),
                        Expanded(
                          child: InfosCard(
                            text1: 'Prix',
                            text2: '${ticket.pass.price} ₣',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 100),
                      child: Divider(height: 0.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.location_24_regular,
                            color: Palette.appRed,
                          ),
                          const Gap(3),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.medium(
                                  '${ticket.event.localizations[0].place}',
                                  maxLine: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                AppText.small('Abidjan - Cocody, Angré'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'From',
                      style: GoogleFonts.sacramento(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Image.asset(
                      'assets/images/izi-logo.png',
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20,
                      ),
                      child: CustomButton(
                        isSetting: true,
                        fontsize: 11,
                        color: Palette.appRed,
                        width: double.infinity,
                        height: 30,
                        radius: 25,
                        text: 'Afficher mon code QR',
                        onPress: () {
                          Functions.showCustomDialog(
                            context: context,
                            child: QrcodeDialog(
                              data: ticket.uniqueCode,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Center(
                    child: Text(
                      '#${ticket.uniqueCode}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class InfosCard extends StatelessWidget {
  const InfosCard({
    super.key,
    this.text1 = 'Date',
    this.text2 = '08/17',
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Palette.appRed.withOpacity(0.7),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  textAlign: TextAlign.center,
                  text2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
