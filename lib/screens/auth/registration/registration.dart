import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../constants/constants.dart';
import '../../../widgets/horizontal_separator.dart';
import '../../../widgets/text_middle.dart';
import '../widgets/email_text_field.dart';
import '../widgets/phone_number_input.dart';
import '../widgets/redirect_to.dart';
import '../widgets/terms_of_us.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.toggleAppBar,
    required this.isEmail,
    required this.toggleTextField,
    required this.onSubmit,
  });
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final VoidCallback toggleAppBar;
  final bool isEmail;
  final VoidCallback toggleTextField;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Gap(45),
        SizedBox(
          width: Functions.contextSize(context).width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 145,
            ),
            child: Image(
              image: AssetImage('assets/images/logo-text-no-bg.png'),
            ),
          ),
        ),
        Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AppText.large(
            'Vos événements à portée de main',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        AppText.small(
          'Se connecter ou s\'inscrire',
          textAlign: TextAlign.center,
          fontSize: 14,
        ),
        Gap(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.bounceIn,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: Offset(1.0, 0.0), // Slide in from right
                end: Offset(0.0, 0.0),
              ).animate(animation);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: isEmail
                ? EmailTextInput(
                    controller: emailController,
                    size: size,
                    onSubmit: onSubmit,
                  )
                : PhoneInput(
                    controller: phoneController,
                    size: size,
                    onSubmit: onSubmit,
                  ),
          ),
        ),
        /*  Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: AppText.medium(
              'OU',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ), */
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          child: textMidleLine(text: 'ou'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: Functions.contextSize(context).width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(46, 61, 68, 74),
            ),
            child: InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              onTap: () => toggleTextField(),
              child: Center(
                child: !isEmail
                    ? continuerWith(
                        icon: FluentIcons.mail_24_filled,
                        text: 'Continuer avec email',
                      )
                    : continuerWith(
                        icon: FluentIcons.phone_24_filled,
                        text: 'Continuer avec téléphone',
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: RedirectTo(
            size: size,
            text: 'Se connecter',
            question: 'Vous avez déjà un compte ? ',
            onPressed: () => toggleAppBar(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: horizontalSeparator(height: 0.8)),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            onTap: () => Functions.launchUri(
              url: termsOFus,
            ),
            child: TermsOfUs(size: size),
          ),
        )
      ],
    );
  }

  Row continuerWith({
    required IconData icon,
    required String text,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Color.fromARGB(255, 27, 30, 32),
          ),
          Gap(8.0),
          AppText.medium(
            text,
            fontSize: 15,
            color: Color.fromARGB(255, 27, 30, 32),
          ),
        ],
      );
}
