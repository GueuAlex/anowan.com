import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return
        //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

        Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText.medium('${thirdPart.name}'),
        const Gap(3),
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
