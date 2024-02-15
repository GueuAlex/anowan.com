import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/all_sheet_header.dart';
import '../../../widgets/custom_button.dart';

class ErrorSheetContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  const ErrorSheetContainer(
      {super.key, required this.text, this.icon = CupertinoIcons.xmark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AllSheetHeader(),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.01),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(200, 10),
              bottomRight: Radius.elliptical(200, 10),
            ),
          ),
          child: Center(
            child: Container(
              // padding: const EdgeInsets.all(20),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppText.medium(
            text,
            textAlign: TextAlign.center,
          ),
        ),
        //AppText.small('Veu')
        Gap(8),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 50,
            left: 50,
          ),
          child: CustomButton(
            color: Palette.appRed,
            width: double.infinity,
            height: 35,
            radius: 5,
            text: 'Retour',
            onPress: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
