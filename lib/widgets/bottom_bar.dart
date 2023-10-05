import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/screens/home/home_screen.dart';
import 'package:ticketwave/side_bar/open_side_dar.dart';

import '../config/palette.dart';
import '../side_bar/custom_side_bar.dart';

class BottomBar extends StatefulWidget {
  static String routeName = '/';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  ///////////////
  /// Bottom menu screens list
  static final List<Widget> _bottomScreens = <Widget>[
    const HomeScreen(),
    AppText.medium("Search"),
    AppText.medium("Ticket"),
    AppText.medium("Profil"),
  ];
  ////////////////////////////
  /// bottom menu initial index
  int bottomMenuInitIndex = 0;
  /////////////////////////////
  /// change bootm menu index
  void _changeBottomIndex({required int selectedIndex}) {
    setState(() {
      bottomMenuInitIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.scafoldColor,
        elevation: 0,
        leading: const OpenSideBar(),
      ),
      drawer: const CustomSiderBar(),
      body: Center(
        child: _bottomScreens[bottomMenuInitIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomMenuInitIndex,
        onTap: (value) => _changeBottomIndex(selectedIndex: value),
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_12_regular),
            label: "Home",
            activeIcon: Icon(
              FluentIcons.home_12_filled,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.search_12_regular),
            label: "Search",
            activeIcon: Icon(
              FluentIcons.search_12_filled,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.ticket_diagonal_16_regular),
            label: "Ticket",
            activeIcon: Icon(
              FluentIcons.ticket_diagonal_16_filled,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.person_12_regular),
            label: "Profil ",
            activeIcon: Icon(
              FluentIcons.person_12_filled,
            ),
          )
        ],
      ),
    );
  }
}
