import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';
import '../config/palette.dart';
import '../screens/auth/auth_screen.dart';
import 'custom_button.dart';
import 'sheet_closer_cross.dart';
import 'text_middle.dart';

class LoginSheet2 extends StatelessWidget {
  const LoginSheet2({
    super.key,
    this.text =
        'On achete pour quelqu\'un seuelement lorsqu\'on a un compte soi meme.',
    this.withClose = true,
    this.withBack = true,
    this.withMiddleText = true,
    this.title = 'Oops !',
    this.width = double.infinity,
    this.fontSize = 16,
  });
  final String text;
  final String title;
  final bool withClose;
  final bool withBack;
  final bool withMiddleText;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
        width: double.infinity,
        //  height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (withClose) sheetCloserCross(ctxt: context),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.separatorColor,
                ),
                child: Center(
                  child: Icon(
                    FluentIcons.key_24_regular,
                  ),
                ),
              ),
              AppText.large(title, fontSize: fontSize),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: AppText.small(
                  text,
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Gap(25),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  // vertical: 4,
                ),
                child: CustomButton(
                  color: Palette.appRed,
                  width: width,
                  height: 40,
                  radius: 5,
                  isSetting: true,
                  fontsize: 13,
                  text: 'Créer mon compte',
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      AuthScreen.routeName,
                    );
                  },
                ),
              ),
              if (withMiddleText)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 5,
                  ),
                  child: textMidleLine(text: 'ou'),
                ),
              if (withBack)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    //vertical: 4,
                  ),
                  child: CustomButton(
                    color: Palette.separatorColor,
                    width: width,
                    height: 40,
                    radius: 5,
                    text: 'Retour',
                    isSetting: true,
                    fontsize: 13,
                    textColor: Colors.black87,
                    onPress: () => Navigator.pop(context),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
