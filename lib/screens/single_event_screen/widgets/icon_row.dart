import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class IconRow extends StatelessWidget {
  const IconRow(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap,
      this.showIcon = true});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon),
              ),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(
                    title,
                    maxLine: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText.medium(
                    subtitle,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    maxLine: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showIcon)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  FluentIcons.chevron_right_24_regular,
                  size: 16,
                  color: Color.fromARGB(255, 50, 50, 50),
                ),
              )
          ],
        ),
      ),
    );
  }
}
