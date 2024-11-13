import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/third_party_model.dart';

class ThirdPartyContainer extends StatelessWidget {
  const ThirdPartyContainer({
    super.key,
    required this.thirdPart,
  });
  final ThirdPartyModel thirdPart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Palette.separatorColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/avion-en-papier.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 63, 63, 63),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium('${thirdPart.name} ${thirdPart.firstname}'),
                Gap(3),
                if (thirdPart.recepient == 'Les deux')
                  Row(
                    children: [
                      recepientTag(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '&',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      recepientTag(text: 'E-mail'),
                    ],
                  )
                else
                  recepientTag(text: thirdPart.recepient),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Container recepientTag({String text = 'SMS'}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Palette.separatorColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
