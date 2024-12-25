import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({
    super.key,
    required this.onChanged,
    required this.value,
    this.title = 'Se souvenir de moi',
    this.subtitle =
        'Pour un prochain achat encore plus rapide et sans tracas !',
  });

  final void Function(bool?)? onChanged;
  final bool value;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox.adaptive(
            value: value,
            onChanged: onChanged,
            checkColor: Colors.white,
            //fillColor: WidgetStatePropertyAll(Palette.appRed),
            activeColor: Palette.appRed,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(7),
                AppText.medium(
                  title,
                  fontWeight: FontWeight.w400,
                ),
                AppText.small(
                  subtitle,
                  fontWeight: FontWeight.w300,
                  maxLine: 2,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
