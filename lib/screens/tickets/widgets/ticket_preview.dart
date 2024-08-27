import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

import 'ticket_delegate.dart';

class TicketPreview extends StatelessWidget {
  final String date;
  final String time;
  final String eventName;
  final String location;
  final String imageUrl;
  final VoidCallback onTap;

  const TicketPreview({
    required this.date,
    required this.time,
    required this.eventName,
    required this.location,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      //margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 250, 250),
        border: Border.all(
          color: Color.fromARGB(255, 201, 201, 201),
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Row(
              children: [
                // First part (2/3 of the width)
                Expanded(
                  //flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$date, $time',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Palette.appRed,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          eventName,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Color.fromARGB(255, 80, 79, 79),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 54, 53, 53),
                                  fontWeight: FontWeight.w300,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Afficher les détails',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second part (1/3 of the width)
                SizedBox(
                  width: 150,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Palette.separatorColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('$imageUrl'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomPaint(
              painter: SideCutsDesign(),
              child: SizedBox(
                height: 150.0,
                width: double.infinity,
              ),
            ),
            CustomPaint(
              painter: DottedMiddlePath(),
              child: SizedBox(
                height: 150.0,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
