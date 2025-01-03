import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/palette.dart';
import '../screens/notification_screen/notification_screen.dart';

class OpenSideBar extends StatelessWidget {
  const OpenSideBar({super.key, this.isWhiteIcon = false});
  final bool isWhiteIcon;

  @override
  Widget build(BuildContext context) {
    //bool isIos = Platform.isIOS;
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                /*  return Scaffold.of(context).openDrawer(); */
                if (Platform.isIOS) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      title: 'Back',
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, NotificationScreen.routeName);
                }
              },
              icon: Transform.rotate(
                angle: 0.35,
                child: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  width: 19.5,
                  // color: isWhiteIcon ? Colors.white : Colors.black,
                  colorFilter: isWhiteIcon
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Palette.appRed,
                  shape: BoxShape.circle,
                ),
              ),
              right: 19,
              bottom: 30,
            ),
          ],
        );
      },
    );
  }
}
