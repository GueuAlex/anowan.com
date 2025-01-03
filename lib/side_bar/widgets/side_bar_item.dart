import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/palette.dart';
import '../../config/app_text.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.icon,
    required this.title,
    this.isLast = false,
    this.isSeleted = false,
    this.onTap,
  });

  final String title;
  final String icon;
  final bool isLast;
  final bool isSeleted;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSeleted
                  ? Palette.secondaryColor.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
            ),
            child: SvgPicture.asset(
              width: 20,
              icon,
              colorFilter: ColorFilter.mode(
                isSeleted ? Palette.secondaryColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          /* leading: Icon(
            icon,
            size: 20,
            color: isSeleted ? Palette.secondaryColor : Colors.black,
          ), */
          title: AppText.medium(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            title,
            /* color: isSeleted ? Palette.secondaryColor : Colors.black, */
          ),
          onTap: onTap,
        ),
        !isLast
            ? Container()
            : const Divider(
                color: Colors.grey,
              ),
      ],
    );
  }
}
