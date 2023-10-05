import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

class TicketDot extends StatelessWidget {
  const TicketDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2.5,
          color: Palette.whiteColor,
        ),
      ),
    );
  }
}
