import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';

import '../config/palette.dart';

class MenuContextuel extends StatelessWidget {
  const MenuContextuel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> menuItems = [
      Row(
        children: [
          Icon(FluentIcons.share_24_regular, color: Colors.black),
          Gap(5),
          AppText.medium(
            'Partager',
            fontWeight: FontWeight.w400,
          )
        ],
      ),
      Row(
        children: [
          Icon(FluentIcons.chat_24_regular, color: Colors.black),
          Gap(5),
          AppText.medium(
            'Contacter l\'organisateur',
            fontWeight: FontWeight.w400,
          )
        ],
      ),
      Row(
        children: [
          Icon(FluentIcons.warning_24_regular, color: Colors.black),
          Gap(5),
          AppText.medium(
            'Signaler cet événement',
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    ];

    return Container(
      height: 35,
      width: 35,
      //padding: const EdgeInsets.only(right: 50),
      decoration: BoxDecoration(
        color: Palette.whiteColor.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: PopupMenuButton<int>(
          position: PopupMenuPosition.under,
          icon: Icon(Icons.more_horiz, color: Palette.blackColor),
          onSelected: (value) {
            print('Vous avez sélectionné : $value');
          },
          itemBuilder: (context) => List.generate(
            menuItems.length,
            (index) => PopupMenuItem(
              value: index,
              child: menuItems[index],
            ),
          ),
        ),
      ),
    );
  }
}
