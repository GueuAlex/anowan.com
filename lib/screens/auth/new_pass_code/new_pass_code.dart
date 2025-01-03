import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_plus_keyboard/package/controllers/pin_input_controller.dart';
import 'package:pin_plus_keyboard/pin_plus_keyboard.dart';

import '../../../config/app_text.dart';
import 'confirm_pass_code.dart';

class NewPassCodeScreen extends StatefulWidget {
  static String routeName = 'NewPassCodeScreen';
  const NewPassCodeScreen({Key? key}) : super(key: key);

  @override
  State<NewPassCodeScreen> createState() => _NewPassCodeScreenState();
}

class _NewPassCodeScreenState extends State<NewPassCodeScreen> {
  PinInputController pinInputController = PinInputController(length: 6);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AppText.medium('Définir un pass code', fontSize: 18),
      ),

      /// ignore: sized_box_for_whitespace
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Veuillez entrer votre code à 4 chiffres",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Renseigner le code d'accès défini lors\nde création du compte",
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
                inputHeight: 20,
                inputWidth: 20,
                isInputHidden: true,
                spacing: size.height * 0.06,
                pinInputController: pinInputController,
                buttonFillColor: Color.fromARGB(255, 6, 18, 24),
                buttonBorderColor: Color.fromARGB(255, 6, 18, 24),
                btnTextColor: Colors.white,
                onSubmit: () {
                  /// ignore: avoid_print
                  print("Text is : " + pinInputController.text);
                  Navigator.of(context).pushReplacementNamed(
                    /*  BottomBar.routeName, */
                    ConfirmPassCodeScreen.routeName,
                  );
                },
                keyboardFontFamily: '',
              ),
              Gap(5),
              /*  Container(
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
                      'Code oublier ?',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
