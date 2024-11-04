import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
//import 'package:ticketwave/config/functions.dart';

import '../config/palette.dart';
import '../screens/annuaire/annuaire_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profil/profil_screen.dart';
import '../screens/profil/widgets/profil_logo.dart';
import '../screens/search/search_screen.dart';
import '../screens/tickets/ticket_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import '../side_bar/open_side_dar.dart';

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
    const AnnuaireScreen(),
    const SearchScreen(),
    const TicketScreen(),
    const ProfilScreen(),
  ];
  ////////////////////////////
  /// bottom menu initial index
  int bottomMenuInitIndex = 2;
  /////////////////////////////
  /// change bootm menu index
  void _changeBottomIndex({required int selectedIndex}) {
    setState(() {
      bottomMenuInitIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialActionss();
  }

  _initialActionss() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Le code ici sera exécuté après le premier rendu de l'UI
      /*  LocalService l = LocalService();
      l.getUser(); */
      await Future.delayed(const Duration(seconds: 5));
      //Functions.showSimpleBottomSheet(ctxt: context, widget: WelcomeScreen());

      Navigator.push(
        context,
        CupertinoPageRoute(
          fullscreenDialog: true,
          title: 'Fermé',
          builder: (context) => const WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.scafoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: bottomMenuInitIndex == 4 || bottomMenuInitIndex == 0
            ? Container(
                width: size.width * 0.24,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  "assets/images/logo-text-short.jpg",
                ),
              )
            : Container(),
        backgroundColor: Colors.white,
        primary: true,
        elevation: 0,
        leading: const OpenSideBar(),
        actions: [
          bottomMenuInitIndex == 4 ? profilLogo(context: context) : Container(),
        ],
      ),
      //drawer: const CustomSiderBar(),
      body: Center(
        child: _bottomScreens[bottomMenuInitIndex],
      ),
      bottomNavigationBar: Container(
        /* padding: const EdgeInsets.only(top: 8), */
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              /* color: Color.fromARGB(255, 227, 227, 227), */
              color: Palette.separatorColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomMenuInitIndex,
          onTap: (value) => _changeBottomIndex(selectedIndex: value),
          elevation: 10,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Palette.appRed,
          unselectedItemColor: const Color(0xFF526480),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_12_regular),
              label: "Accueil",
              activeIcon: Icon(
                FluentIcons.home_12_filled,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.book_16_regular),
              label: "Annuaire",
              activeIcon: Icon(
                FluentIcons.book_16_filled,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.search_12_regular),
              label: "Découvrir",
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
              label: "Moi ",
              activeIcon: Icon(
                FluentIcons.person_12_filled,
              ),
            )
          ],
        ),
      ),
    );
  }
}
