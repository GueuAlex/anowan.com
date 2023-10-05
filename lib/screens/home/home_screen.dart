import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/widgets/ticket_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scafoldColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          'Good mrning',
                          color: Colors.grey.shade500,
                        ),
                        const Gap(5),
                        AppText.large('Book Tickets')
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/img_1.png'),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(25),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 252, 252, 255),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.search_12_regular,
                        color: Colors.grey.shade500,
                      ),
                      const Gap(5),
                      AppText.medium('Search', color: Colors.grey.shade500)
                    ],
                  ),
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.large(
                      'Upcoming',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText.medium(
                      'View all',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Palette.textColor,
                    ),
                  ],
                )

                /////////
                ///
              ],
            ),
          ),
          //////////////
          ///
          const Gap(15),
          const TicketView()
          ////////////
          ///
        ],
      ),
    );
  }
}
