import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../widgets/build_icon.dart';
import '../profil_settings/profil_settings.dart';
import '../settings/app_settings_screen.dart';

class TopIcons extends StatelessWidget {
  const TopIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIcon(
              svgPath: 'assets/icons/angle-petit-gauche.svg',
              onTap: () => Navigator.of(context).pop(),
            ),
            Row(
              children: [
                buildIcon(
                  svgPath: 'assets/icons/crayon1.svg',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilSettings(),
                    ),
                  ),
                ),
                Gap(8),
                buildIcon(
                  svgPath: 'assets/icons/settings.svg',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AppSettingsScreen(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
