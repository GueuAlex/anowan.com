import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import 'favorites.dart';
import 'participe.dart';
import 'suggestion_container.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({
    super.key,
  });

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Évènements à venir',
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
                  'PARTICIPE',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  1,
                  Icons.star,
                  'FAVORITES',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  2,
                  Icons.settings,
                  'SUGGESTIONS',
                ),
              ),
            ],
          ),
        ),
        Gap(20),
        IndexedStack(
          index: _selectedIndex,
          children: [
            participed(size: size),
            favorites(size: size),
            suggestions(size: size, context: context)
          ],
        ),
      ],
    );
  }

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
