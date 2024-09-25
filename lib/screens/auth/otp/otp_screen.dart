import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:pin_plus_keyboard/package/controllers/pin_input_controller.dart';
import 'package:pin_plus_keyboard/pin_plus_keyboard.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';

import '../../../remote_service/remote_service.dart';
import '../user_infos/take_user_infos.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = 'OtpScreen';
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PinInputController pinInputController = PinInputController(length: 6);
  int? _otpCode;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as OTPScrenArgs;
    print('args otp: ${args.otp}');
    print('widget opt: ${_otpCode}');
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  args.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Nous avons envoyé un code de vérification à\n${args.login}",
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
                cancelColor: Palette.appRed,
                doneButton: Icon(
                  CupertinoIcons.check_mark,
                  color: Palette.appRed,
                ),
                buttonFillColor: /* Color.fromARGB(255, 6, 18, 24) */
                    Palette.appRed,
                buttonBorderColor: /* Color.fromARGB(255, 6, 18, 24) */
                    Palette.appRed,
                btnTextColor: Colors.white,
                onSubmit: () => _onSubmit(args),
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
                    onPressed: () => _resendOpt(args),
                    child: AppText.small(
                      'Renvoyer le code',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Palette.appRed,
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

  void _resendOpt(OTPScrenArgs args) async {
    EasyLoading.show();
    if (args.isEmail) {
      Map<String, dynamic> _payload = {
        'email': args.login,
      };
      await RemoteService()
          .postSomethings(
        api: 'users/verify',
        data: _payload,
      )
          .then((r) {
        EasyLoading.dismiss();
        if (r.statusCode == 401 || r.statusCode == 200 || r.statusCode == 201) {
          Functions.showToast(
            msg: 'Un nouveau code a été envoyé à votre adresse mail',
          );
          var json = jsonDecode(r.body);
          int? _apiOtp = int.tryParse(json['otp']);
          if (_apiOtp != null) {
            setState(() {
              _otpCode = _apiOtp;
            });
          } else {
            Functions.showToast(msg: 'Erreur lors de l\'envoi du code');
          }
        }
        EasyLoading.dismiss();
      });
    }
  }

  _onSubmit(OTPScrenArgs args) async {
    EasyLoading.show();
    await Future.delayed(const Duration(seconds: 3));
    int _putOtp = int.parse(pinInputController.text);
    if (_otpCode != null) {
      if (_putOtp == _otpCode) {
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(
            /*  NewPassCodeScreen.routeName, */ /* PassCodeScreen.routeName, */
            TakeUserInfos.routeName,
            arguments: args);
      } else {
        Functions.showToast(msg: 'Le code saisi est incorrect');
        EasyLoading.dismiss();
      }
    } else {
      if (_putOtp == int.parse(args.otp)) {
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(
            /*  NewPassCodeScreen.routeName, */ /* PassCodeScreen.routeName, */
            TakeUserInfos.routeName,
            arguments: args);
      } else {
        Functions.showToast(msg: 'Le code saisi est incorrect');
        EasyLoading.dismiss();
      }
    }
  }
}

class OTPScrenArgs {
  final String login;
  final String otp;
  final String title;
  final bool isEmail;
  final String? zipCode;
  OTPScrenArgs({
    required this.login,
    required this.otp,
    required this.title,
    required this.isEmail,
    this.zipCode,
  });
}
