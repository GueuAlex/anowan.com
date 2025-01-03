import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/functions.dart';
import '../../model/side_bar_item.dart';
import '../config/app_text.dart';
import '../config/palette.dart';
import 'widgets/side_bar_item.dart';

class CustomSiderBar extends StatefulWidget {
  const CustomSiderBar({super.key});

  @override
  State<CustomSiderBar> createState() => _CustomSiderBarState();
}

class _CustomSiderBarState extends State<CustomSiderBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.white,
      width: size.width / 1.3,
      child: Stack(
        children: [
          Container(
            height: paddingTop,
            width: double.infinity,
            color: Palette.secondaryColor,
          ),
          SafeArea(
            bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Palette.secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(180, 100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Anowan.com',
                      style: GoogleFonts.fuggles(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: buildMenuItems(context),
                ),
                builBottomArea(context, paddingBottom)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(SideBarItemModel.tab.length, (index) {
          bool showDivider = false;
          if (index == 4 || index == 8) {
            showDivider = true;
          }
          return SideBarItem(
            isLast: showDivider,
            icon: SideBarItemModel.tab[index].svg,
            title: SideBarItemModel.tab[index].title,
            isSeleted: SideBarItemModel.selectedIndex == index,
            onTap: () {
              setState(() {
                SideBarItemModel.selectedIndex = index;
              });

              if (SideBarItemModel.tab[index].routeName.isNotEmpty) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SideBarItemModel.tab[index].routeName, (route) => false);
              } else {
                Navigator.pop(context);
                Functions.showSnackBar(
                  ctxt: context,
                  messeage: 'Disponible bientôt',
                );
              }
            },
          );
        }),
      ),
    );
  }

  Widget builBottomArea(BuildContext context, double paddingBottom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: AppText.medium(
            'organisateur@email.com',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        SideBarItem(
          icon: 'assets/icons/logout.svg',
          title: 'Déconnexion',
          onTap: () {
            Navigator.pop(context);
            Functions.showSnackBar(
              ctxt: context,
              messeage: 'Disponible bientôt',
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
