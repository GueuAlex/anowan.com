import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';

import 'widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ////////////////////:::
  ///
  bool _isButtonVisible = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _isButtonVisible = _scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
    });
  }

  ///
  /////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      floatingActionButton: MyFloatingButton(isButtonVisible: _isButtonVisible),
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // const Gap(35),
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
                        AppText.large('Événements populaires', fontSize: 18)
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logo-text.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(25),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.primaryColor.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.search_12_regular,
                        color: Colors.grey.shade500,
                        size: 22,
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
                      'Ce mois',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText.medium(
                      'Voir tout',
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            //color: Colors.red,
            child: Column(
              children: List.generate(
                5,
                (index) => EventCard(index: index),
              ),
            ),
          )
          ////////////
          ///
        ],
      ),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({
    super.key,
    required bool isButtonVisible,
  }) : _isButtonVisible = isButtonVisible;

  final bool _isButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isButtonVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 130,
            height: 35,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    FluentIcons.location_24_filled,
                    size: 15,
                    color: Palette.primaryColor,
                  ),
                  Gap(5),
                  Expanded(
                    child: Center(
                      child: AppText.medium(
                        'Abidjan',
                        textOverflow: TextOverflow.ellipsis,
                        color: Palette.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gap(5),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
