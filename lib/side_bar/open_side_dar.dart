import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpenSideBar extends StatelessWidget {
  const OpenSideBar({super.key, this.isWhiteIcon = false});
  final bool isWhiteIcon;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          onPressed: () {
            return Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            // color: isWhiteIcon ? Colors.white : Colors.black,
            colorFilter: isWhiteIcon
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        );
      },
    );
  }
}
