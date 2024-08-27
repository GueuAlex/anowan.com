import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../widgets/build_link.dart';

class SocialMediaView extends StatelessWidget {
  const SocialMediaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          AppText.small(
            'Consulter et abonner vous à différents comptes sur les réseaux sociaux pour suivre nos actualités ',
            fontSize: 14,
          ),
          Gap(25),
          link(
            svgPath: 'assets/icons/global-line.svg',
            text: 'Site Web',
            subText: 'Vistez notre site pour plus de détails',
            onTap: () {},
          ),
          Gap(10),
          link(
            svgPath: 'assets/icons/facebook-line.svg',
            text: 'Facebook',
            subText: 'Voir plus de réalisations sur Facebook',
            onTap: () {},
          ),
          Gap(10),
          link(
            svgPath: 'assets/icons/instagram-line.svg',
            text: 'Instagram',
            subText: 'Vous pouvez nous suivre sur Instagram',
            onTap: () {},
          ),
          Gap(10),
          link(
            svgPath: 'assets/icons/linkedin-fill.svg',
            text: 'LinkedIn',
            subText: 'Consultez notre page sur LinkedIn',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
