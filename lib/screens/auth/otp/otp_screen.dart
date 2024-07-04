import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_plus_keyboard/package/controllers/pin_input_controller.dart';
import 'package:pin_plus_keyboard/pin_plus_keyboard.dart';
import 'package:ticketwave/config/app_text.dart';

import '../new_pass_code/new_pass_code.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = 'OtpScreen';
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PinInputController pinInputController = PinInputController(length: 6);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AppText.medium('OPT vérification', fontSize: 18),
      ),

      /// ignore: sized_box_for_whitespace
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Véfirions votre numéro",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Nous avons envoyé un code de vérification à\n+225 07 007 078 000",
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53),
                      fontWeight: FontWeight.w300,
                      fontSize: size.width * 0.035),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              PinPlusKeyBoardPackage(
                keyboardButtonShape: KeyboardButtonShape.circular,
                inputShape: InputShape.circular,
                spacing: size.height * 0.06,
                pinInputController: pinInputController,
                buttonFillColor: Color.fromARGB(255, 6, 18, 24),
                buttonBorderColor: Color.fromARGB(255, 6, 18, 24),
                btnTextColor: Colors.white,
                onSubmit: () {
                  /// ignore: avoid_print
                  print("Text is : " + pinInputController.text);
                  Navigator.of(context).pushReplacementNamed(
                    NewPassCodeScreen.routeName, /* PassCodeScreen.routeName, */
                  );
                },
                keyboardFontFamily: '',
              ),
              Gap(5),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      // Splash color
                      backgroundColor: Colors.transparent, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      splashFactory: InkRipple.splashFactory, // Ripple effect
                    ),
                    onPressed: () {},
                    child: AppText.small(
                      'Renvoyer le code',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
